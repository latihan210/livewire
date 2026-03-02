<?php

use Illuminate\Support\Facades\Route;
use Laravel\Fortify\Http\Controllers\RegisteredUserController;
use App\Livewire\Frontend\Referral;
use App\Livewire\Member\MemberUpgrade;
use App\Livewire\Member\MemberRo;
use App\Livewire\Member\MemberList;
use App\Livewire\Member\MemberGroup;
use App\Livewire\Member\MemberTree;
use App\Livewire\Member\MemberGeneration;
use App\Livewire\Commission\Bonus;
use App\Livewire\Commission\Ewallet;
use App\Livewire\Commission\Statement;
use App\Livewire\Commission\Withdraw;
use App\Livewire\Commission\Transfer;
use App\Livewire\Stockist\StockistNew;
use App\Livewire\Stockist\StockistList;
use App\Livewire\Stockist\ProductStock;
use App\Livewire\Stockist\StockAdjustment;
use App\Livewire\Pin\PinGenerate;
use App\Livewire\Pin\PinTransfer;
use App\Livewire\Pin\PinHistory;
use App\Livewire\Report\Sales;
use App\Livewire\Report\Omzet;
use App\Livewire\Report\Reward;
use App\Livewire\Shopping\ShopList;
use App\Livewire\Shopping\Cart;
use App\Livewire\Shopping\Checkout;
use App\Livewire\Shopping\Invoice;

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

    Route::get('/member/new', [RegisteredUserController::class, 'create'])
        ->name('member.new');

    // Member Page Routes
    Route::prefix('member')->name('member.')->group(function () {
        Route::get('upgrade', MemberUpgrade::class)->name('upgrade');
        Route::get('ro', MemberRo::class)->name('ro');
        Route::get('lists', MemberList::class)->name('lists');
        Route::get('group/{id?}', MemberGroup::class)->name('group');
        Route::get('tree/{id?}', MemberTree::class)->name('tree');
        Route::get('generation/{id?}', MemberGeneration::class)->name('generation');
    });

    // Commission & E-Wallet Routes
    Route::prefix('commission')->name('commission.')->group(function () {
        Route::get('bonus', Bonus::class)->name('bonus');
        Route::get('ewallet', Ewallet::class)->name('ewallet');
        Route::get('statement', Statement::class)->name('statement');
        Route::get('withdraw', Withdraw::class)->name('withdraw');
        Route::get('transfer', Transfer::class)->name('transfer');
    });

    // Stockist Page Routes
    Route::prefix('stockist')->name('stockist.')->group(function () {
        Route::get('new', StockistNew::class)->name('new');
        Route::get('lists', StockistList::class)->name('lists');
        Route::get('product-stock', ProductStock::class)->name('product-stock');
        Route::get('adjustment', StockAdjustment::class)->name('adjustment');
    });

    // PIN Page Routes
    Route::prefix('pin')->name('pin.')->group(function () {
        Route::get('generate', PinGenerate::class)->name('generate');
        Route::get('transfer', PinTransfer::class)->name('transfer');
        Route::get('history', PinHistory::class)->name('history');
    });

    // Report Page Routes
    Route::prefix('report')->name('report.')->group(function () {
        Route::get('sales', Sales::class)->name('sales');
        Route::get('omzet', Omzet::class)->name('omzet');
        Route::get('reward', Reward::class)->name('reward');
    });

    // Shopping Routes
    Route::prefix('shopping')->name('shopping.')->group(function () {
        Route::get('shop', ShopList::class)->name('list');
        Route::get('cart', Cart::class)->name('cart');
        Route::get('checkout', Checkout::class)->name('checkout');
        Route::get('invoice/{id}', Invoice::class)->name('invoice');
    });
});

// 4. File Bawaan Laravel
require __DIR__ . '/settings.php';

// 5. Fallback (Sistem Referral)
Route::fallback(Referral::class);
