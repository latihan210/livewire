<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Hash;

class MigrasiUserSeeder extends Seeder
{
    public function run()
    {
        // Matikan proteksi Foreign Key sementara
        DB::statement('SET FOREIGN_KEY_CHECKS = 0;');

        // ====================================================================
        // 1. MAPPING USERS SECARA KESELURUHAN (Semua Kolom Disedot)
        // ====================================================================
        $this->command->info("Proses: jpb_member -> users (Menyalin seluruh kolom)...");
        DB::table('users')->truncate();

        // Ambil struktur kolom di database Laravel Anda
        $userCols = Schema::getColumnListing('users');
        $members = DB::connection('latihan')->table('jpb_member')->get();
        $usersData = [];
        $usedEmails = [];

        foreach ($members as $m) {
            $data = (array)$m;
            $filtered = [];

            // A. Pindahkan semua data jika nama kolomnya sama persis (idcard, address, dll)
            foreach ($userCols as $col) {
                if (array_key_exists($col, $data)) {
                    $filtered[$col] = $data[$col];
                }
            }

            // B. Sesuaikan kolom yang berubah nama atau butuh pembersihan
            $filtered['created_at'] = $this->cleanDate($data['datecreated'] ?? null);
            $filtered['updated_at'] = $this->cleanDate($data['datemodified'] ?? null);

            // C. PASSWORD LOGIC
            // Cek apakah password lama sudah berupa hash (diawali $2y$ atau $2a$)
            $oldPassword = $data['password'];
            if (str_starts_with($oldPassword, '$2y$') || str_starts_with($oldPassword, '$2a$')) {
                $filtered['password'] = $oldPassword; // Sudah hash, salin langsung
            } else {
                $filtered['password'] = Hash::make($oldPassword); // Belum hash (plain text), kita hash sekarang
            }

            // D. Proteksi Email Duplikat
            $email = trim($data['email'] ?? '');
            if (empty($email)) {
                $email = $data['username'] . '@mail.com';
            }
            if (in_array($email, $usedEmails)) {
                $email = $data['username'] . '.' . $email;
            }
            $usedEmails[] = $email;
            $filtered['email'] = $email;

            $usersData[] = $filtered;
        }

        // Simpan ke database users
        foreach (array_chunk($usersData, 500) as $chunk) {
            DB::table('users')->insert($chunk);
        }

        // ====================================================================
        // 2. MAPPING TRANSAKSI & MASTER (Otomatis menyesuaikan kolom)
        // ====================================================================
        $masters = [
            'jpb_withdraw' => 'withdraw',
            'jpb_bonus'    => 'bonus',
            'jpb_area'     => 'area',
            'jpb_banks'    => 'banks',
            'jpb_product'  => 'product',
            'jpb_news'     => 'news',
            'jpb_staff'    => 'staff',
            'jpb_auto_ro'  => 'auto_ro',
            'jpb_ewallet'  => 'ewallet',
            'jpb_pin'      => 'pin'
        ];

        foreach ($masters as $old => $new) {
            if (Schema::hasTable($new) && Schema::connection('latihan')->hasTable($old)) {
                $this->command->info("Memindahkan: $old -> $new...");
                DB::table($new)->truncate();

                $cols = Schema::getColumnListing($new);
                $sourceData = DB::connection('latihan')->table($old)->get();
                $insertData = [];

                foreach ($sourceData as $row) {
                    $data = (array)$row;
                    $filtered = [];

                    foreach ($cols as $col) {
                        // Fix perubahan nama kolom khusus untuk tabel bonus
                        if ($old === 'jpb_bonus' && $col === 'type') {
                            $filtered[$col] = $data['bonus_type'] ?? 1;
                        }
                        // Sedot jika ada
                        elseif (array_key_exists($col, $data)) {
                            $val = $data[$col];
                            // Bersihkan semua kolom tanggal
                            if (str_contains($col, 'date') || str_contains($col, 'time')) {
                                $val = $this->cleanDate($val, true);
                            }
                            $filtered[$col] = $val;
                        }
                        // Tambal kolom angka yang wajib ada tapi tidak ada di database lama
                        else {
                            if (in_array($col, ['nominal_receipt', 'tax', 'auto_ro', 'admin_fund', 'amount_tax'])) {
                                $filtered[$col] = 0;
                            }
                        }
                    }
                    $insertData[] = $filtered;
                }

                if (!empty($insertData)) {
                    foreach (array_chunk($insertData, 500) as $chunk) {
                        DB::table($new)->insert($chunk);
                    }
                }
            }
        }

        DB::statement('SET FOREIGN_KEY_CHECKS = 1;');
        $this->command->info("MIGRASI SELESAI TOTAL & SELURUH KOLOM BERHASIL DISEDOT!");
    }

    // Fungsi otomatis untuk mengatasi error format waktu 0000-00-00
    private function cleanDate($val, $allowNull = false)
    {
        if (empty($val) || $val === '0000-00-00 00:00:00' || $val === '0000-00-00') {
            return $allowNull ? null : now()->format('Y-m-d H:i:s');
        }
        return $val;
    }
}
