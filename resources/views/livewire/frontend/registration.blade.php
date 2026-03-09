<div>
    <h2 class='text-xl font-bold'>Halaman registration</h2>
    <p>Ini adalah tampilan sementara untuk komponen frontend.</p>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">Formulir Pendaftaran Member Baru</h4> <!-- reg_member_formulir -->
                </div>
                <div class="card-body">
                    
                    @error('general')
                        <div class="alert alert-danger" role="alert">
                            {{ $message }}
                        </div>
                    @enderror

                    <form wire:submit="register">
                        
                        <!-- Informasi Jaringan -->
                        <h5 class="mb-3 text-muted">Informasi Jaringan</h5>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="sponsor_username" class="form-label">Username Sponsor</label> <!-- reg_sponsor_username -->
                                <input type="text" id="sponsor_username" class="form-control @error('sponsor_username') is-invalid @enderror" wire:model.lazy="sponsor_username" placeholder="Contoh: sponsor123">
                                @error('sponsor_username') <div class="invalid-feedback">{{ $message }}</div> @enderror
                            </div>
                            <div class="col-md-6">
                                <label for="upline_username" class="form-label">Username Upline</label> <!-- reg_upline_username -->
                                <input type="text" id="upline_username" class="form-control @error('upline_username') is-invalid @enderror" wire:model.lazy="upline_username" placeholder="Contoh: upline123">
                                @error('upline_username') <div class="invalid-feedback">{{ $message }}</div> @enderror
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="position" class="form-label">Posisi</label> <!-- position -->
                            <select id="position" class="form-select @error('position') is-invalid @enderror" wire:model="position">
                                <option value="">Pilih Posisi</option>
                                <option value="left">Kiri (Left)</option>
                                <option value="right">Kanan (Right)</option>
                            </select>
                            @error('position') <div class="invalid-feedback">{{ $message }}</div> @enderror
                        </div>

                        <hr>

                        <!-- Informasi Member -->
                        <h5 class="mb-3 text-muted">Informasi Member</h5> <!-- reg_member_information -->
                        
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label> <!-- username -->
                            <input type="text" id="username" class="form-control @error('username') is-invalid @enderror" wire:model.lazy="username" placeholder="Username yang dikehendaki">
                            @error('username') <div class="invalid-feedback">{{ $message }}</div> @enderror
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="password" class="form-label">Password</label> <!-- reg_password -->
                                <input type="password" id="password" class="form-control @error('password') is-invalid @enderror" wire:model="password">
                                @error('password') <div class="invalid-feedback">{{ $message }}</div> @enderror
                            </div>
                            <div class="col-md-6">
                                <label for="password_confirmation" class="form-label">Konfirmasi Password</label> <!-- reg_password_confirm -->
                                <input type="password" id="password_confirmation" class="form-control" wire:model="password_confirmation">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="name" class="form-label">Nama Lengkap</label> <!-- reg_fullname -->
                            <input type="text" id="name" class="form-control @error('name') is-invalid @enderror" wire:model="name">
                            @error('name') <div class="invalid-feedback">{{ $message }}</div> @enderror
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="email" class="form-label">Email</label> <!-- reg_email -->
                                <input type="email" id="email" class="form-control @error('email') is-invalid @enderror" wire:model.lazy="email">
                                @error('email') <div class="invalid-feedback">{{ $message }}</div> @enderror
                            </div>
                            <div class="col-md-6">
                                <label for="phone" class="form-label">No. HP/WA</label> <!-- reg_no_hp -->
                                <input type="text" id="phone" class="form-control @error('phone') is-invalid @enderror" wire:model="phone">
                                @error('phone') <div class="invalid-feedback">{{ $message }}</div> @enderror
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="idcard" class="form-label">No. KTP</label> <!-- reg_no_ktp -->
                            <input type="text" id="idcard" class="form-control @error('idcard') is-invalid @enderror" wire:model="idcard">
                            @error('idcard') <div class="invalid-feedback">{{ $message }}</div> @enderror
                        </div>

                        <hr>

                        <!-- Informasi Akun Bank -->
                        <h5 class="mb-3 text-muted">Informasi Akun Bank</h5> <!-- reg_bank_information -->
                        
                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label for="bank_name" class="form-label">Nama Bank</label> <!-- reg_bank -->
                                <select id="bank_name" class="form-select @error('bank_name') is-invalid @enderror" wire:model="bank_name">
                                    <option value="">Pilih Bank</option>
                                    <option value="BCA">BCA</option>
                                    <option value="MANDIRI">MANDIRI</option>
                                    <option value="BRI">BRI</option>
                                    <option value="BNI">BNI</option>
                                </select>
                                @error('bank_name') <div class="invalid-feedback">{{ $message }}</div> @enderror
                            </div>
                            <div class="col-md-4">
                                <label for="bank_account_number" class="form-label">No. Rekening</label> <!-- reg_no_rekening -->
                                <input type="text" id="bank_account_number" class="form-control @error('bank_account_number') is-invalid @enderror" wire:model="bank_account_number">
                                @error('bank_account_number') <div class="invalid-feedback">{{ $message }}</div> @enderror
                            </div>
                            <div class="col-md-4">
                                <label for="bank_account_name" class="form-label">Pemilik Rekening</label> <!-- reg_pemilik_rek -->
                                <input type="text" id="bank_account_name" class="form-control @error('bank_account_name') is-invalid @enderror" wire:model="bank_account_name">
                                @error('bank_account_name') <div class="invalid-feedback">{{ $message }}</div> @enderror
                            </div>
                        </div>

                        <div class="d-grid gap-2 mt-4">
                            <button type="submit" class="btn btn-primary btn-lg" wire:loading.attr="disabled">
                                <span wire:loading.remove>Daftarkan</span> <!-- reg_register -->
                                <span wire:loading>Memproses...</span>
                            </button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
