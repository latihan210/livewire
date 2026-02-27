<?php

use Livewire\Component;

new class extends Component
{
    //
};
?>

<div class="p-4">
    <div class="mb-4">
        <input wire:model.live="search" type="text" class="form-control w-25" placeholder="Cari nama atau username...">
    </div>

    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>No</th>
                    <th>Username</th>
                    <th>Nama Lengkap</th>
                    <th>Email</th>
                    <th>Tanggal Join</th>
                </tr>
            </thead>
            <tbody>
                @foreach($members as $index => $member)
                <tr>
                    <td>{{ $members->firstItem() + $index }}</td>
                    <td><span class="badge bg-primary">{{ $member->username }}</span></td>
                    <td>{{ $member->name }}</td>
                    <td>{{ $member->email }}</td>
                    <td>{{ $member->created_at->format('d M Y') }}</td>
                </tr>
                @endforeach
            </tbody>
        </table>
    </div>

    <div class="mt-3">
        {{ $members->links() }}
    </div>
</div>