<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name', 100);
            $table->string('username', 200)->unique('userunique');
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->string('package', 20)->default('free');
            $table->bigInteger('sponsor')->default(0)->comment('Sponsor Recruitement')->index();
            $table->string('sponsor_uid', 200)->nullable();
            $table->bigInteger('parent')->default(0)->comment('Parent of Tree')->index();
            $table->string('parent_uid', 200)->nullable();
            $table->string('position', 15)->default('')->comment('root for admin');
            $table->integer('group')->default(0);
            $table->integer('gen')->default(0);
            $table->integer('level')->default(0);
            $table->longText('tree_sponsor')->nullable();
            $table->longText('tree')->nullable();
            $table->string('phone', 20)->nullable()->index();
            $table->string('password_pin', 255)->default('');
            $table->string('password_trx', 255)->nullable();
            $table->integer('type')->default(1)->comment('1=Administrator,2=Member')->index();
            $table->integer('status')->default(0)->comment('0=Not Active,1=Active,2=Banned,3=Deleted')->index();
            $table->date('birthdate')->nullable();
            $table->string('gender', 255)->nullable();
            $table->string('idcard', 50)->nullable();
            $table->string('npwp', 50)->nullable()->default('');
            $table->string('country', 10)->nullable();
            $table->smallInteger('province')->default(0);
            $table->smallInteger('district')->default(0);
            $table->smallInteger('subdistrict')->nullable();
            $table->string('village', 100)->nullable();
            $table->text('address')->nullable();
            $table->integer('bank')->default(0);
            $table->string('bill', 20)->nullable();
            $table->string('bill_name', 255)->nullable();
            $table->text('photo')->nullable();
            $table->text('idcard_img')->nullable();
            $table->string('qrcode_img', 200)->nullable();
            $table->double('total_omzet')->default(0);
            $table->double('package_omzet')->default(0);
            $table->string('rank', 30)->nullable()->index();
            $table->string('referral_code', 20)->nullable();
            $table->tinyInteger('as_stockist')->default(0)->comment('1=ms, 2=stockist, 3=master');
            $table->tinyInteger('as_stockist_pusat')->default(0);
            $table->string('stockist_name', 100)->nullable();
            $table->smallInteger('stockist_province')->nullable();
            $table->smallInteger('stockist_district')->nullable();
            $table->smallInteger('stockist_subdistrict')->nullable();
            $table->string('stockist_village', 100)->nullable();
            $table->text('stockist_address')->nullable();
            $table->bigInteger('to_stockist')->default(0);
            $table->smallInteger('shop_invoice')->default(0);
            $table->smallInteger('shop_uniquecode')->default(0);
            $table->tinyInteger('wd_status')->default(1)->comment('0="Otomatis Sistem"; 1="Manual WD"');
            $table->integer('wd_min')->default(0);
            $table->tinyInteger('agree_ethic')->default(0);
            $table->smallInteger('change_password')->default(0);
            $table->dateTime('last_login')->nullable();
            $table->bigInteger('member_hu')->default(0)->index();
            $table->integer('is_ro')->default(0)->index();
            $table->rememberToken();
            $table->timestamps();
        });

        Schema::create('password_reset_tokens', function (Blueprint $table) {
            $table->string('email')->primary();
            $table->string('token');
            $table->timestamp('created_at')->nullable();
        });

        Schema::create('sessions', function (Blueprint $table) {
            $table->string('id')->primary();
            $table->foreignId('user_id')->nullable()->index();
            $table->string('ip_address', 45)->nullable();
            $table->text('user_agent')->nullable();
            $table->longText('payload');
            $table->integer('last_activity')->index();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
        Schema::dropIfExists('password_reset_tokens');
        Schema::dropIfExists('sessions');
    }
};
