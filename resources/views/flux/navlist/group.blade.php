@props([
'expandable' => false,
'expanded' => true,
'heading' => null,
'icon' => null,
])

<?php if ($expandable && $heading): ?>
    <ui-disclosure
        {{ $attributes->class('group/disclosure w-full') }}
        @if ($expanded===true) close @endif
        data-flux-navlist-group>

        <button
            type="button"
            class="group/disclosure-button mb-[1px] flex h-10 w-full items-center rounded-lg text-zinc-500 hover:bg-zinc-800/8 hover:text-zinc-800 lg:h-9 dark:text-white/70 dark:hover:bg-white/[7%] dark:hover:text-white transition-all duration-200">

            <div class="flex! items-center justify-center w-[40px] shrink-0">
                @if ($icon)
                <flux:icon :icon="$icon" variant="outline" class="size-5! shrink-0" />
                @endif
            </div>

            <div class="flex flex-1 items-center overflow-hidden group-data-[collapsed]:hidden">
                <span class="ms-1 text-sm font-medium leading-none flex-1 text-left truncate">
                    {{ $heading }}
                </span>

                <div class="pe-2 text-zinc-400/80 dark:text-zinc-500">
                    <flux:icon.chevron-right class="block size-3.5! transition-transform duration-200 group-data-open/disclosure-button:rotate-90" />
                </div>
            </div>
        </button>

        <div
            class="relative hidden space-y-[1px] mt-2 data-open:block group-data-[collapsed]:!hidden"
            @if ($expanded===true) data-open @endif>

            <div class="inset-y-0 start-0 ms-[19px] w-[1px] bg-zinc-200 dark:bg-zinc-700/60"></div>

            <div class="ps-10">
                {{ $slot }}
            </div>
        </div>
    </ui-disclosure>

<?php elseif ($heading): ?>
    <div {{ $attributes->class('block space-y-[2px]') }}>
        <div class="px-1 py-2 group-data-[collapsed]:hidden">
            <div class="text-xs leading-none text-zinc-400 uppercase tracking-wider">{{ $heading }}</div>
        </div>

        <div>
            {{ $slot }}
        </div>
    </div>

<?php else: ?>
    <div {{ $attributes->class('block space-y-[2px]') }}>
        {{ $slot }}
    </div>
<?php endif; ?>