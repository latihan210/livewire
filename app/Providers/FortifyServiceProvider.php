<?php

namespace App\Providers;

use App\Actions\Fortify\CreateNewUser;
use App\Actions\Fortify\ResetUserPassword;
use App\Models\User;
use Illuminate\Cache\RateLimiting\Limit;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Str;
use Laravel\Fortify\Fortify;
use Illuminate\Support\Facades\Event;
use Illuminate\Auth\Events\Login;

class FortifyServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        $this->configureActions();
        $this->configureViews();
        $this->configureRateLimiting();

        Event::listen(Login::class, function ($event) {
            $event->user->forceFill([
                'last_login' => now(),
            ])->save();
        });

        Fortify::authenticateUsing(function (Request $request) {
            $user = User::where('username', $request->input('username'))->first();

            if ($user) {
                // 1. Cek Login Normal (Bcrypt - Bawaan Laravel)
                if (Hash::check($request->password, $user->password)) {
                    // OPTIONAL: Jika password masih pakai cost rendah (05) dari sistem lama,
                    // otomatis update ke standar baru (cost 10/12) agar lebih aman.
                    if (Hash::needsRehash($user->password)) {
                        $user->forceFill([
                            'password' => $request->password,
                        ])->save();
                    }
                    return $user;
                }

                // 2. Cek Login Legacy (MD5 - Migrasi)
                // MD5 selalu 32 karakter. Kita cek manual.
                if (strlen($user->password) === 32 && $user->password === md5($request->password)) {

                    $user->forceFill([
                        'password' => $request->password,
                    ])->save();

                    return $user;
                }
            }

            // Login gagal
            return null;
        });
    }

    /**
     * Configure Fortify actions.
     */
    private function configureActions(): void
    {
        Fortify::resetUserPasswordsUsing(ResetUserPassword::class);
        Fortify::createUsersUsing(CreateNewUser::class);
    }

    /**
     * Configure Fortify views.
     */
    private function configureViews(): void
    {
        Fortify::loginView(fn() => view('pages::auth.login'));
        Fortify::verifyEmailView(fn() => view('pages::auth.verify-email'));
        Fortify::twoFactorChallengeView(fn() => view('pages::auth.two-factor-challenge'));
        Fortify::confirmPasswordView(fn() => view('pages::auth.confirm-password'));
        Fortify::registerView(fn() => view('pages::auth.register'));
        Fortify::resetPasswordView(fn() => view('pages::auth.reset-password'));
        Fortify::requestPasswordResetLinkView(fn() => view('pages::auth.forgot-password'));
    }

    /**
     * Configure rate limiting.
     */
    private function configureRateLimiting(): void
    {
        RateLimiter::for('two-factor', function (Request $request) {
            return Limit::perMinute(5)->by($request->session()->get('login.id'));
        });

        RateLimiter::for('login', function (Request $request) {
            $throttleKey = Str::transliterate(Str::lower($request->input(Fortify::username())) . '|' . $request->ip());

            return Limit::perMinute(5)->by($throttleKey);
        });
    }
}
