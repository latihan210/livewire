<?php

namespace App\Actions\Fortify;

use App\Concerns\PasswordValidationRules;
use App\Concerns\ProfileValidationRules;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Laravel\Fortify\Contracts\CreatesNewUsers;

class CreateNewUser implements CreatesNewUsers
{
    use PasswordValidationRules, ProfileValidationRules;

    /**
     * Validate and create a newly registered user.
     *
     * @param  array<string, string>  $input
     */
    public function create(array $input): User
    {
        Validator::make($input, [
            ...$this->profileRules(),
            'username' => ['required', 'string', 'max:200', 'unique:users'],
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => $this->passwordRules(),
        ])->validate();

        return User::create([
            'username' => $input['username'],
            'name' => $input['name'],
            'email' => $input['email'],
            'password' => Hash::make($input['password']),
            // Default values
            'package' => 'free',
            'sponsor' => 0,
            'parent' => 0,
            'position' => '',
            'group' => 0,
            'gen' => 0,
            'level' => 0,
            'tree_sponsor' => '',
            'tree' => '',
            'province' => 0,
            'district' => 0,
            'bank' => 0,
            'total_omzet' => 0,
            'package_omzet' => 0,
            'as_stockist' => 0,
            'as_stockist_pusat' => 0,
            'to_stockist' => 0,
            'shop_invoice' => 0,
            'shop_uniquecode' => 0,
            'change_password' => 0,
            'member_hu' => 0,
            'is_ro' => 0,
        ]);
    }
}
