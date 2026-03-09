<?php
// $currency           = config_item('currency');
// $currency_coin      = config_item('coins');
$time               = date('H');
$fisrt_date         = date('Y-m-01');
$this_month         = date('Y-m', strtotime($fisrt_date));
$last_month         = date('Y-m', strtotime('-1 day', strtotime($fisrt_date)));
$hi                 = '';
$name               = auth()->user()->name;
$dashboard_admin    = true;
$agree_ethic        = false;
$first_login        = false;

// if ($staff = dha_get_current_staff()) {
//     $name   = $staff->name;
//     if ($staff->access == 'partial') {
//         $dashboard_admin = false;
//     }
// }

if ($time >= '00' && $time <= '09') {
    $hi = 'Selamat Pagi';
} elseif ($time > '09' && $time <= '14') {
    $hi = 'Selamat Siang';
} elseif ($time > '14' && $time <= '18') {
    $hi = 'Selamat Sore';
} elseif ($time > '18' && $time <= '24') {
    $hi = 'Selamat Malam';
}

// if ($is_admin) {
$total_member       = 0;
$total_join_today   = 0;
$total_omzet        = 0;
$total_bonus        = 0;

$start              = date('Y-m-01', strtotime('-5 month'));
$end                = date('Y-m-d');

$start              = $month = strtotime($start);
$end                = strtotime($end);
$period             = array();
while ($month < $end) {
    $period_month = date('Y-m', $month);
    $month = strtotime("+1 month", $month);
    $period[$period_month] = $period_month;
}
foreach ($period as $value) {
    $omzet_label[]  = date('M, Y', strtotime($value));
    $omzet_data['order'][]      = 0;
    $omzet_data['posting'][]    = 0;

    $member_label[] = date('M, Y', strtotime($value));
    $join_data[]    = 0;
}

$chart_omzet_data   = json_encode($omzet_data);
$chart_omzet_label  = '"' . implode('","', $omzet_label) . '"';
// } else {
$cfg_ranks          = 'ranks';
$rank_member        = isset($cfg_ranks[auth()->user()->rank]) ? $cfg_ranks[auth()->user()->rank] : strtoupper(str_replace('_', ' ', auth()->user()->rank));

$packagedata        = auth()->user()->package;
$packae_member      = isset($packagedata->package_name) ? $packagedata->package_name : 'Member';

$status_member      = (auth()->user()->status == 1) ? 'Active' : 'Non Active';
$status_class       = (auth()->user()->status == 1) ? 'text-primary' : 'text-danger';

// $tree_left          = auth()->user()->id;       // Count Result Tree Left 
$count_left         = 0;       // Count Downline Left 
$pair_left          = 0;         // Count Pairing Left 
$reward_left        = 0;           // Count Reward Perdana Left 

// $tree_right         = auth()->user()->id;      // Count Result Tree Right
$count_right        = 0;     // Count Downline Right
$pair_right         = 0;       // Count Pairing Right
$reward_right       = 0;         // Count Reward Perdana Right

// Get Pairing Qualified
// $pairing_qualified  = $this->Model_Member->count_pairing_qualified(auth()->user()->id, true, date('Y-m-d', strtotime('-1 day')));
// if ($pairing_qualified) {
//     $pair_left      = $pair_left - $pairing_qualified;
//     $pair_right     = $pair_right - $pairing_qualified;
//     $pair_left      = max(0, $pair_left);
//     $pair_right     = max(0, $pair_right);
// }

// $dha_is_assuming    = dha_is_assuming();
// if (! $is_admin && ! $dha_is_assuming) {
//     $agree_ethic    = (! auth()->user()->agree_ethic) ? true : false;
// }

// if (! $agree_ethic && ! $is_admin && ! $dha_is_assuming) {
//     if (auth()->user()->status > 0 && ! trim(auth()->user()->change_password)) {
//         $first_login = true;
//     }
// }

//$server_name        = SERVER_NAME;
$link_ref           = strtolower(auth()->user()->username);
// $link_ref           = base_url($link_ref);

$ro_period          = false;

$trip_left          = 0;
$trip_right         = 0;

$booster_left       = 0;
$booster_right      = 0;
// }

?>
<x-layouts::app :title="__('Dashboard')">
    <div class="flex h-full w-full flex-1 flex-col gap-4 rounded-xl">
        <div class="col-lg-12">
            <?php
            $welcome_text   = "$hi, " . ucwords(strtolower($name)) . "!";
            echo $welcome_text;
            ?>
        </div>
        <div class="grid auto-rows-min gap-4 md:grid-cols-3">
            <div
                class="relative aspect-video overflow-hidden rounded-xl border border-neutral-200 dark:border-neutral-700">
                <x-placeholder-pattern
                    class="absolute inset-0 size-full stroke-gray-900/20 dark:stroke-neutral-100/20" />
            </div>
            <div
                class="relative aspect-video overflow-hidden rounded-xl border border-neutral-200 dark:border-neutral-700">
                <x-placeholder-pattern
                    class="absolute inset-0 size-full stroke-gray-900/20 dark:stroke-neutral-100/20" />
            </div>
            <div
                class="relative aspect-video overflow-hidden rounded-xl border border-neutral-200 dark:border-neutral-700">
                <x-placeholder-pattern
                    class="absolute inset-0 size-full stroke-gray-900/20 dark:stroke-neutral-100/20" />
            </div>
        </div>
        <div
            class="relative h-full flex-1 overflow-hidden rounded-xl border border-neutral-200 dark:border-neutral-700">
            <x-placeholder-pattern class="absolute inset-0 size-full stroke-gray-900/20 dark:stroke-neutral-100/20" />
        </div>
    </div>
</x-layouts::app>