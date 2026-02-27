<?php

namespace App\Livewire\Member;

use App\Models\User;
use Livewire\Component;
use Livewire\WithPagination;

class MemberList extends Component
{
    use WithPagination;

    public $search = '';

    // Reset halaman ke nomor 1 jika user melakukan pencarian
    public function updatingSearch()
    {
        $this->resetPage();
    }

    public function render()
    {
        return view('livewire.member.member-list', [
            'members' => User::where('name', 'like', '%' . $this->search . '%')
                ->orWhere('username', 'like', '%' . $this->search . '%')
                ->latest()
                ->paginate(10)
        ]);
    }
}
