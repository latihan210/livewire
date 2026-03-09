<x-layouts::app.sidebar :title="$title ?? null">
    <x-layouts::app.header>
    </x-layouts::app.header>
    <flux:main>
        {{ $slot }}
        <footer class="space-x-1 text-sm text-center rtl:space-x-reverse text-zinc-600 dark:text-zinc-400 mt-2">
            <span>&copy; {{ config('app.name') }} {{ date('Y') }}</span>
        </footer>
    </flux:main>
</x-layouts::app.sidebar>