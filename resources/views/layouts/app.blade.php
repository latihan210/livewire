<x-layouts::app.sidebar :title="$title ?? null">
    <x-layouts::app.header>
    </x-layouts::app.header>
    <flux:main>
        {{ $slot }}
    </flux:main>
</x-layouts::app.sidebar>