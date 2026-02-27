<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class MigrasiUserSeeder extends Seeder
{
    public function run()
    {
        DB::statement('SET FOREIGN_KEY_CHECKS = 0;');

        // --- A. USERS ---
        $this->command->info("Proses: jpb_member -> users...");
        DB::table('users')->truncate();
        $members = DB::connection('latihan')->table('jpb_member')->get();
        $usedEmails = [];

        foreach ($members as $m) {
            $created = ($m->datecreated == '0000-00-00 00:00:00' || !$m->datecreated) ? now() : $m->datecreated;
            $updated = ($m->datemodified == '0000-00-00 00:00:00' || !$m->datemodified) ? $created : $m->datemodified;
            $email = trim($m->email);
            if (empty($email)) {
                $email = $m->username . '@mail.com';
            }
            if (in_array($email, $usedEmails)) {
                $email = $m->username . '.' . $email;
            }
            $usedEmails[] = $email;

            DB::table('users')->insert([
                'id' => $m->id,
                'username' => $m->username,
                'password' => $m->password,
                'name' => $m->name,
                'email' => $email,
                'phone' => $m->phone,
                'sponsor' => $m->sponsor,
                'parent' => $m->parent,
                'position' => $m->position,
                'bank' => $m->bank,
                'bill' => $m->bill,
                'bill_name' => $m->bill_name,
                'status' => $m->status,
                'created_at' => $created,
                'updated_at' => $updated,
            ]);
        }

        // --- B. WITHDRAW (Verified: Both use 'id_member' and 'bill') ---
        $this->command->info("Proses: jpb_withdraw -> withdraw...");
        DB::table('withdraw')->truncate();
        foreach (DB::connection('latihan')->table('jpb_withdraw')->get() as $wd) {
            DB::table('withdraw')->insert([
                'id' => $wd->id,
                'id_member' => $wd->id_member, // SESUAI SQL: Bukan member_id
                'bank' => $wd->bank,
                'bill' => $wd->bill,
                'bill_name' => $wd->bill_name,
                'nominal' => $wd->nominal,
                'status' => $wd->status,
                'datecreated' => ($wd->datecreated == '0000-00-00 00:00:00') ? now() : $wd->datecreated,
                'datemodified' => ($wd->datemodified == '0000-00-00 00:00:00') ? now() : $wd->datemodified,
            ]);
        }

        // --- C. BONUS (Verified: Both use 'id_member', Source uses 'bonus_type', Target uses 'type') ---
        $this->command->info("Proses: jpb_bonus -> bonus...");
        DB::table('bonus')->truncate();
        foreach (DB::connection('latihan')->table('jpb_bonus')->get() as $b) {
            DB::table('bonus')->insert([
                'id' => $b->id,
                'id_member' => $b->id_member, // SESUAI SQL: Bukan member_id
                'type' => $b->bonus_type,
                'nominal' => $b->nominal,
                'description' => $b->description,
                'status' => $b->status,
                'datecreated' => ($b->datecreated == '0000-00-00 00:00:00') ? now() : $b->datecreated,
            ]);
        }

        // --- D. MASTER TABLES (Verified Column Mappings) ---
        $masters = [
            'jpb_area' => 'area',
            'jpb_banks' => 'banks',
            'jpb_config' => 'config',
            'jpb_product' => 'product',
            'jpb_news' => 'news',
            'jpb_staff' => 'staff',
            'jpb_auto_ro' => 'auto_ro',
            'jpb_ewallet' => 'ewallet',
            'jpb_pin' => 'pin'
        ];

        foreach ($masters as $old => $new) {
            if (Schema::hasTable($new)) {
                $this->command->info("Memindahkan: $old...");
                DB::table($new)->truncate();
                $cols = Schema::getColumnListing($new);
                foreach (DB::connection('latihan')->table($old)->get() as $row) {
                    $data = (array)$row;
                    // Mapping Manual untuk jpb_pin karena di target kolomnya 'type'
                    if ($old == 'jpb_pin' && isset($data['pin_type'])) {
                        $data['type'] = $data['pin_type'];
                    }

                    // Filter agar hanya kolom yang ada di tabel tujuan yang dimasukkan
                    $filtered = array_intersect_key($data, array_flip($cols));
                    DB::table($new)->insert($filtered);
                }
            }
        }

        DB::statement('SET FOREIGN_KEY_CHECKS = 1;');
        $this->command->info("MIGRASI SELESAI TOTAL!");
    }
}
