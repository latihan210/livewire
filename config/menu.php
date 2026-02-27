<?php

return [
    'member_data' => [
        'heading' => 'Data Member',
        'icon' => 'users',
        'items' => [
            ['label' => 'Member Baru', 'route' => 'member.new'],
            ['label' => 'Semua Member', 'route' => 'member.lists'],
            ['label' => 'List Group Member', 'route' => 'member.group'],
            // ['label' => 'Member Rank', 'route' => 'member.rank'],
            // ['label' => 'Member Summary', 'route' => 'member.overview'],
            // ['label' => 'List Sponsor', 'route' => 'member.sponsor'],
            ['label' => 'Pohon Jaringan', 'route' => 'member.tree'],
        ],
    ],
    'commission' => [
        'heading' => 'Komisi & Bonus',
        'icon' => 'banknotes',
        'items' => [
            ['label' => 'Bonus Saya', 'route' => 'commission.bonus'],
            ['label' => 'Statement', 'route' => 'commission.statement'],
            ['label' => 'E-Wallet', 'route' => 'commission.ewallet'],
            // ['label' => 'Auto RO', 'route' => 'commission.autoro'],
            ['label' => 'Withdraw', 'route' => 'commission.withdraw'],
        ],
    ],
    'products' => [
        'heading' => 'Data Produk & Order',
        'icon' => 'shopping-bag',
        'items' => [
            ['label' => 'Kirim Produk', 'route' => 'pin.generate'],
            // ['label' => 'Stock Produk', 'route' => 'pin.datalists'],
            ['label' => 'History PIN', 'route' => 'pin.history'],
            // ['label' => 'Orderan Perusahaan', 'route' => 'pin.sales'],
        ],
    ],
    'shopping' => [
        'heading' => 'Shopping',
        'icon' => 'shopping-cart',
        'items' => [
            ['label' => 'Keranjang Belanja', 'route' => 'shopping.cart'],
            ['label' => 'Toko / Shop', 'route' => 'shopping.list'],
            // ['label' => 'Riwayat Belanja', 'route' => 'shopping.history'],
        ],
    ],
    'reports' => [
        'heading' => 'Laporan / Report',
        'icon' => 'document-chart-bar',
        'items' => [
            // ['label' => 'Laporan Registrasi', 'route' => 'report.registration'],
            // ['label' => 'Laporan RO', 'route' => 'report.ro'],
            // ['label' => 'Laporan Pairing', 'route' => 'report.pairing'],
            // ['label' => 'Omzet Harian', 'route' => 'report.omzet.daily'],
            // ['label' => 'Omzet Bulanan', 'route' => 'report.omzet.monthly'],
            // ['label' => 'Laporan Pajak', 'route' => 'report.tax'],
            // ['label' => 'Laporan Reward', 'route' => 'report.reward'],
        ],
    ],
    'settings' => [
        'heading' => 'Master Setting',
        'icon' => 'cog-6-tooth',
        'items' => [
            // ['label' => 'General Setting', 'route' => 'setting.general'],
            // ['label' => 'Notification', 'route' => 'setting.notification'],
            // ['label' => 'Setting Reward', 'route' => 'setting.reward'],
            // ['label' => 'Setting Withdraw', 'route' => 'setting.withdraw'],
        ],
    ],
];
