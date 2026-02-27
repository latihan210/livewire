<?php

use Illuminate\Support\Facades\Route;

// 1. Halaman Publik / Redirect
Route::get('/', function () {
    return redirect()->route('login');
});

// 2. Rute Bawaan Laravel (Dashboard)
Route::view('dashboard', 'dashboard')
    ->middleware(['auth', 'verified'])
    ->name('dashboard');

// 3. Rute Aplikasi Lengkap (Pindahan CI3 ke Livewire)
Route::middleware(['auth', 'verified'])->group(function () {

    Route::get('/member/new', [\Laravel\Fortify\Http\Controllers\RegisteredUserController::class, 'create'])
        ->name('member.new');

    // Member Page Routes
    Route::prefix('member')->name('member.')->group(function () {
        Route::get('upgrade', \App\Livewire\Member\MemberUpgrade::class)->name('upgrade');
        Route::get('ro', \App\Livewire\Member\MemberRo::class)->name('ro');
        Route::get('lists', \App\Livewire\Member\MemberList::class)->name('lists');
        Route::get('group/{id?}', \App\Livewire\Member\MemberGroup::class)->name('group');
        Route::get('tree/{id?}', \App\Livewire\Member\MemberTree::class)->name('tree');
        Route::get('generation/{id?}', \App\Livewire\Member\MemberGeneration::class)->name('generation');
    });

    // Commission & E-Wallet Routes
    Route::prefix('commission')->name('commission.')->group(function () {
        Route::get('bonus', \App\Livewire\Commission\Bonus::class)->name('bonus');
        Route::get('ewallet', \App\Livewire\Commission\Ewallet::class)->name('ewallet');
        Route::get('statement', \App\Livewire\Commission\Statement::class)->name('statement');
        Route::get('withdraw', \App\Livewire\Commission\Withdraw::class)->name('withdraw');
        Route::get('transfer', \App\Livewire\Commission\Transfer::class)->name('transfer');
    });

    // Stockist Page Routes
    Route::prefix('stockist')->name('stockist.')->group(function () {
        Route::get('new', \App\Livewire\Stockist\StockistNew::class)->name('new');
        Route::get('lists', \App\Livewire\Stockist\StockistList::class)->name('lists');
        Route::get('product-stock', \App\Livewire\Stockist\ProductStock::class)->name('product-stock');
        Route::get('adjustment', \App\Livewire\Stockist\StockAdjustment::class)->name('adjustment');
    });

    // PIN Page Routes
    Route::prefix('pin')->name('pin.')->group(function () {
        Route::get('generate', \App\Livewire\Pin\PinGenerate::class)->name('generate');
        Route::get('transfer', \App\Livewire\Pin\PinTransfer::class)->name('transfer');
        Route::get('history', \App\Livewire\Pin\PinHistory::class)->name('history');
    });

    // Report Page Routes
    Route::prefix('report')->name('report.')->group(function () {
        Route::get('sales', \App\Livewire\Report\Sales::class)->name('sales');
        Route::get('omzet', \App\Livewire\Report\Omzet::class)->name('omzet');
        Route::get('reward', \App\Livewire\Report\Reward::class)->name('reward');
    });

    // Shopping Routes
    Route::prefix('shopping')->name('shopping.')->group(function () {
        Route::get('shop', \App\Livewire\Shopping\ShopList::class)->name('list');
        Route::get('cart', \App\Livewire\Shopping\Cart::class)->name('cart');
        Route::get('checkout', \App\Livewire\Shopping\Checkout::class)->name('checkout');
        Route::get('invoice/{id}', \App\Livewire\Shopping\Invoice::class)->name('invoice');
    });
});

// 4. File Bawaan Laravel
require __DIR__ . '/settings.php';

// 5. Fallback (Sistem Referral)
Route::fallback(\App\Livewire\Frontend\Referral::class);
