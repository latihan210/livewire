<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('area', function (Blueprint $table) {
            $table->smallIncrements('id');
            $table->string('area_name', 30);
            $table->string('area_code', 10)->nullable()->default('');
        });

        Schema::create('auto_ro', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member');
            $table->bigInteger('id_source');
            $table->string('source', 30)->nullable();
            $table->double('nominal');
            $table->tinyInteger('percent')->comment('IN, OUT');
            $table->double('amount');
            $table->boolean('status');
            $table->text('description')->nullable();
            $table->dateTime('datecreated');

            $table->unique(['id_member', 'id_source', 'source']);
            $table->index('percent');
        });

        Schema::create('auto_ro_out', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member')->index();
            $table->bigInteger('id_source')->index();
            $table->string('source', 20)->comment('bonus, topup, shop, withdraw, transfer')->index();
            $table->integer('amount');
            $table->integer('status')->comment('1 = active, 0 = inactive');
            $table->text('description');
            $table->dateTime('datecreated');

            $table->unique(['id_member', 'id_source', 'source'], 'routunique');
        });

        Schema::create('banks', function (Blueprint $table) {
            $table->integer('id', true);
            $table->string('nama', 150);
            $table->string('kode', 3)->index();
            $table->string('type', 30)->nullable()->default('bank');
            $table->string('flipcode', 50)->nullable()->default('')->index();
            $table->string('espaycode', 20)->nullable()->index();
            $table->string('linkitacode', 50)->nullable();
            $table->string('logo', 255)->nullable();
        });

        Schema::create('bonus', function (Blueprint $table) {
            $table->id();
            $table->string('id_bonus', 50)->index();
            $table->bigInteger('id_member')->index();
            $table->integer('type')->comment('1=Sponsor,2=Pairing')->index();
            $table->text('desc')->nullable();
            $table->integer('status');
            $table->double('amount')->index();
            $table->double('tax');
            $table->double('amount_tax');
            $table->dateTime('datecreated');
            $table->dateTime('datemodified');
        });

        Schema::create('bonus_generation_refs', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_bonus')->index();
            $table->bigInteger('id_member')->index();
            $table->bigInteger('id_downline');
            $table->tinyInteger('gen')->comment('bonus, topup, shop, withdraw, transfer');
            $table->string('type', 30)->nullable();
            $table->integer('omzet');
            $table->tinyInteger('percentage')->comment('IN, OUT');
            $table->integer('amount');
            $table->smallInteger('year')->index();
            $table->tinyInteger('month')->index();
            $table->date('date')->nullable()->index();
            $table->boolean('status');
            $table->text('description')->nullable();
            $table->dateTime('dateomzet')->nullable()->index();
            $table->dateTime('datecreated');
        });

        Schema::create('bonus_level_refs', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_bonus')->index();
            $table->bigInteger('id_member')->index();
            $table->bigInteger('id_downline');
            $table->smallInteger('level')->comment('bonus, topup, shop, withdraw, transfer')->index();
            $table->smallInteger('level_downline')->index();
            $table->integer('omzet');
            $table->tinyInteger('percentage')->comment('IN, OUT');
            $table->integer('amount');
            $table->smallInteger('year')->index();
            $table->tinyInteger('month')->index();
            $table->date('date')->nullable()->index();
            $table->boolean('status');
            $table->text('description')->nullable();
            $table->dateTime('dateomzet')->nullable()->index();
            $table->dateTime('datecreated');
        });

        Schema::create('bonus_matching_refs', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_bonus_pairing')->index();
            $table->bigInteger('id_bonus_matching')->index();
            $table->bigInteger('id_member')->index();
            $table->bigInteger('id_downline');
            $table->tinyInteger('gen')->comment('bonus, topup, shop, withdraw, transfer');
            $table->tinyInteger('percentage')->comment('IN, OUT');
            $table->integer('bonus');
            $table->integer('amount');
            $table->boolean('status');
            $table->text('description')->nullable();
            $table->dateTime('datecreated');
        });

        Schema::create('cart', function (Blueprint $table) {
            $table->string('id', 200)->primary();
            $table->string('cart_code', 255)->unique();
            $table->bigInteger('id_member')->index('cart_member');
            $table->string('type', 255)->nullable();
            $table->string('grouping', 50)->index('cart_group');
            $table->integer('grouping_id')->index('cart_groupid');
            $table->integer('product_id')->index('cart_product');
            $table->integer('package_id')->index('cart_package');
            $table->integer('varian_id')->index('cart_varian');
            $table->string('name', 255)->nullable();
            $table->double('weight')->nullable();
            $table->double('bv');
            $table->double('price')->nullable();
            $table->integer('qty')->nullable();
            $table->double('subtotal')->nullable();
            $table->integer('total_item');
            $table->text('items')->nullable();
            $table->tinyInteger('status')->default(1);
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();
        });

        Schema::create('country', function (Blueprint $table) {
            $table->integer('id', true);
            $table->char('iso', 2);
            $table->string('name', 80);
            $table->string('nicename', 80);
            $table->char('iso3', 3)->nullable()->index();
            $table->smallInteger('numcode')->nullable();
            $table->integer('phonecode');
            $table->boolean('status')->default(0);
        });

        Schema::create('district', function (Blueprint $table) {
            $table->integer('id', true);
            $table->smallInteger('province_id')->index('idx_province_id');
            $table->string('district_name', 200);
            $table->string('district_type', 50)->nullable()->default('');
            $table->string('district_code', 20)->nullable()->default('');
            $table->string('postal_code', 10)->nullable()->default('');
            $table->integer('id_express');
            $table->text('lion')->nullable();
            // Indexing text column requires prefix length in raw SQL
            $table->index([DB::raw('lion(768)')], 'idx_id_lion');
        });

        Schema::create('eproduct', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member')->index();
            $table->bigInteger('id_source');
            $table->string('source', 20)->comment('bonus, topup, shop, withdraw, transfer')->index();
            $table->string('category', 20)->default('product')->comment('product, shipping');
            $table->double('amount');
            $table->string('type', 5)->comment('IN, OUT')->index();
            $table->integer('status')->comment('1 = active, 0 = inactive');
            $table->text('description');
            $table->dateTime('datecreated');
        });

        Schema::create('ewallet', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member')->index();
            $table->bigInteger('id_source');
            $table->string('source', 20)->comment('bonus, topup, shop, withdraw, transfer')->index();
            $table->string('category', 50)->default('commission')->comment('commission, profit');
            $table->integer('nominal');
            $table->tinyInteger('percent');
            $table->integer('autoro');
            $table->integer('tax');
            $table->integer('amount');
            $table->string('type', 5)->comment('IN, OUT')->index();
            $table->integer('status')->comment('1 = active, 0 = inactive');
            $table->text('description');
            $table->dateTime('datecreated');

            $table->unique(['id_member', 'id_source', 'source'], 'walletunique');
        });

        Schema::create('ewallet_transfer', function (Blueprint $table) {
            $table->id();
            $table->string('id_transfer', 30)->index('ewt_id_transfer');
            $table->bigInteger('id_member_sender')->index('ewt_id_member_sender');
            $table->string('username_sender', 255);
            $table->bigInteger('id_member')->index('ewt_id_member');
            $table->string('username', 255);
            $table->integer('nominal');
            $table->integer('nominal_receipt');
            $table->integer('admin_fund');
            $table->boolean('status')->default(1)->index('ewt_status');
            $table->text('description')->nullable();
            $table->dateTime('datecreated')->index('ewt_date');
            $table->dateTime('datemodified');
            $table->string('created_by', 100)->nullable();
        });

        Schema::create('keys', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member');
            $table->string('name', 150)->nullable()->default('');
            $table->string('key', 100)->nullable()->default('');
            $table->tinyInteger('level')->default(1);
            $table->tinyInteger('ignore_limits');
            $table->boolean('is_private_key');
            $table->string('ip_addresses', 100)->nullable();
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();
        });

        Schema::create('log', function (Blueprint $table) {
            $table->bigIncrements('log_id');
            $table->string('log_name', 100)->index();
            $table->dateTime('log_time');
            $table->string('log_status', 50);
            $table->text('log_desc')->nullable();
        });

        Schema::create('log_action', function (Blueprint $table) {
            $table->id();
            $table->string('name', 100)->index('log_act_name');
            $table->string('status', 50);
            $table->string('username', 20)->nullable()->default('');
            $table->string('ip', 50)->nullable();
            $table->string('user_agent', 255)->nullable();
            $table->string('platform', 255)->nullable();
            $table->text('desc')->nullable();
            $table->string('assum', 255)->nullable()->default('');
            $table->string('assum_staff', 255)->nullable()->default('');
            $table->dateTime('datetime')->nullable();
        });

        Schema::create('log_api', function (Blueprint $table) {
            $table->id();
            $table->string('name', 100)->index('log_act_name');
            $table->string('status', 50);
            $table->string('username', 20)->nullable()->default('');
            $table->string('ip', 50)->nullable();
            $table->string('user_agent', 255)->nullable();
            $table->string('platform', 255)->nullable();
            $table->text('desc')->nullable();
            $table->text('token')->nullable();
            $table->dateTime('datetime')->nullable();
        });

        Schema::create('log_cron', function (Blueprint $table) {
            $table->id();
            $table->string('cron_name', 100)->index('log_name');
            $table->string('status', 50);
            $table->dateTime('start_time');
            $table->dateTime('end_time');
            $table->text('log_desc')->nullable();
        });

        Schema::create('log_notif', function (Blueprint $table) {
            $table->id();
            $table->string('category', 100)->nullable();
            $table->string('title', 100)->nullable();
            $table->string('send', 100)->nullable();
            $table->text('message')->nullable();
            $table->string('status', 50)->nullable();
            $table->timestamp('date')->useCurrent();
            $table->bigInteger('user_id')->nullable();
            $table->bigInteger('user_2nd')->nullable();
        });

        Schema::create('member_confirm', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member');
            $table->string('member', 255);
            $table->bigInteger('id_sponsor');
            $table->string('sponsor', 255);
            $table->bigInteger('id_upline');
            $table->string('upline', 255)->nullable();
            $table->bigInteger('id_downline');
            $table->string('downline', 255);
            $table->string('package', 50)->nullable();
            $table->tinyInteger('package_count')->default(1);
            $table->string('position', 10)->nullable();
            $table->integer('status')->comment('0=Review,1=Confirmed');
            $table->string('access', 10)->comment('admin, pin');
            $table->bigInteger('id_shop_order');
            $table->string('referral_code', 100)->nullable()->default('');
            $table->double('bv');
            $table->double('nominal');
            $table->double('shipping');
            $table->smallInteger('uniquecode');
            $table->double('total_payment');
            $table->dateTime('datecreated');
            $table->dateTime('datemodified');
            $table->dateTime('dateconfirmed')->nullable();
            $table->string('confirm_by', 100)->nullable()->default('');
        });

        Schema::create('member_omzet', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member')->index('mo_id_member');
            $table->double('pack_omzet');
            $table->double('bv');
            $table->double('sponsor')->comment('Sponsor Point');
            $table->double('pairing')->comment('Pairing Point');
            $table->double('reward')->comment('Reward Point');
            $table->double('ro');
            $table->double('omzet');
            $table->double('price');
            $table->double('amount');
            $table->string('status', 100)->nullable()->index('mo_status');
            $table->text('desc')->nullable();
            $table->date('date')->index('mo_date');
            $table->dateTime('datecreated')->index('mo_datecreated');
            $table->dateTime('datemodified')->nullable();
        });

        Schema::create('member_point', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member')->index('MP_id_member');
            $table->string('type', 20)->index('MP_type');
            $table->smallInteger('period')->default(0)->index('MP_period');
            $table->date('period_start')->nullable();
            $table->date('period_end')->nullable();
            $table->double('point_left');
            $table->double('point_right');
            $table->double('point_qualified');
            $table->integer('status')->default(1);
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();

            $table->unique(['id_member', 'type', 'period'], 'MP_unique');
        });

        Schema::create('member_report', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member')->unique('MR_unique');
            $table->double('pairing_left');
            $table->double('pairing_right');
            $table->double('pairing_qualified');
            $table->double('reward_left');
            $table->double('reward_right');
            $table->double('total_omzet');
            $table->double('total_ro_omzet');
            $table->double('total_ro_point');
            $table->double('last_ro_omzet');
            $table->double('last_ro_point');
            $table->dateTime('last_ro_date')->nullable();
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();
        });

        Schema::create('news', function (Blueprint $table) {
            $table->integer('id', true);
            $table->string('title', 200)->index();
            $table->string('slug', 255)->nullable()->unique();
            $table->text('content')->nullable();
            $table->string('mime_type', 50)->nullable();
            $table->text('url')->nullable();
            $table->enum('status', ['publish', 'draft', 'delete'])->default('publish')->index();
            $table->dateTime('created_at');
            $table->dateTime('updated_at')->nullable();
        });

        Schema::create('notification', function (Blueprint $table) {
            $table->id();
            $table->string('name', 255);
            $table->string('slug', 255)->index();
            $table->string('title', 255)->nullable()->default('');
            $table->longText('content');
            $table->integer('status')->index();
            $table->string('type', 50)->default('');
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();
        });

        Schema::create('options', function (Blueprint $table) {
            $table->integer('id_option', true);
            $table->string('name', 255);
            $table->text('value')->nullable();
        });

        Schema::create('otp', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member');
            $table->string('email', 191)->nullable()->default('')->index();
            $table->string('type', 50)->nullable()->default('')->index('type_otp');
            $table->string('ip_address', 45)->nullable();
            $table->string('platform', 50)->nullable();
            $table->string('browser', 100)->nullable();
            $table->text('agent')->nullable();
            $table->text('user_agent')->nullable();
            $table->string('otp', 10)->nullable()->default('')->index();
            $table->integer('expiration')->unsigned()->nullable()->index('last_activity_idx');
            $table->tinyInteger('status');
            $table->dateTime('datecreated')->nullable();
            $table->dateTime('datemodified')->nullable();

            $table->unique(['id_member', 'email', 'type'], 'user_idx');
        });

        Schema::create('package', function (Blueprint $table) {
            $table->string('package', 50)->primary();
            $table->string('package_name', 100);
            $table->tinyInteger('package_index');
            $table->tinyInteger('package_count')->default(1);
            $table->integer('bv');
            $table->integer('nominal');
            $table->tinyInteger('sponsor_percent');
            $table->tinyInteger('passup_percent');
            $table->tinyInteger('pairing_percent');
            $table->integer('pairing_nominal')->comment('Rp');
            $table->integer('pairing_max')->comment('BV');
            $table->smallInteger('pairing_point');
            $table->double('reward_point');
            $table->text('description')->nullable();
            $table->boolean('is_register');
            $table->tinyInteger('is_order');
            $table->boolean('is_active')->default(1);
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();
            $table->string('modified_by', 200)->nullable();
        });

        Schema::create('pairing_point', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member')->index('PP_id_member');
            $table->string('package', 50);
            $table->string('type', 20)->index('PP_type');
            $table->integer('bv');
            $table->double('point');
            $table->integer('status')->default(1);
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();
        });

        Schema::create('pairing_qualified', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member')->index('PQ_id_member');
            $table->double('left');
            $table->double('right');
            $table->double('qualified');
            $table->double('total_point');
            $table->double('carry_left');
            $table->double('carry_right');
            $table->double('kurs');
            $table->tinyInteger('status')->default(1);
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();
        });

        Schema::create('pin', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_order_pin');
            $table->string('id_pin', 30);
            $table->bigInteger('id_member')->index('pin_id_member');
            $table->bigInteger('id_member_owner');
            $table->bigInteger('id_member_register')->index('pin_id_member_register');
            $table->bigInteger('id_member_registered')->index('pin_id_member_registered');
            $table->integer('product')->index('pin_product');
            $table->integer('varian')->default(0);
            $table->string('type', 50)->nullable()->default('');
            $table->integer('bv');
            $table->bigInteger('amount');
            $table->integer('status')->comment('0=Pending,1=Active,2=Used')->index('pin_status');
            $table->string('used', 20)->nullable()->default('');
            $table->text('description')->nullable();
            $table->dateTime('datecreated');
            $table->dateTime('datemodified');
            $table->date('dateexpired')->nullable();
            $table->dateTime('dateused')->nullable();
        });

        Schema::create('pin_transfer', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member_sender')->index('pt_id_member_sender');
            $table->string('username_sender', 255);
            $table->bigInteger('id_member')->index('pt_id_member');
            $table->string('username', 255);
            $table->bigInteger('id_pin')->index('pt_id_pin');
            $table->integer('product')->index('pt_product');
            $table->integer('varian')->default(0);
            $table->integer('product_package')->default(0);
            $table->integer('amount');
            $table->integer('price_member');
            $table->string('type', 50)->nullable()->default('transfer_pin');
            $table->text('description')->nullable();
            $table->dateTime('datecreated');
            $table->dateTime('datemodified');
        });

        Schema::create('product', function (Blueprint $table) {
            $table->id();
            $table->string('sku', 100)->nullable();
            $table->string('name', 200)->index('product_name');
            $table->string('slug', 255)->index('porduct_slug');
            $table->string('type', 50)->default('')->comment('All=Reg+RO')->index('idx_type');
            $table->string('varian', 255)->nullable();
            $table->tinyInteger('hu');
            $table->integer('bv');
            $table->integer('price_hpp');
            $table->integer('price');
            $table->integer('price_member');
            $table->integer('price_customer');
            $table->double('sponsor_point');
            $table->double('pairing_point');
            $table->double('reward_point');
            $table->double('stockist_point');
            $table->integer('reward_budget');
            $table->double('weight')->nullable()->comment('Weight = Gram');
            $table->integer('stock');
            $table->text('description')->nullable();
            $table->string('image', 255)->nullable()->default('');
            $table->text('s3_upload')->nullable();
            $table->tinyInteger('show_order')->nullable()->default(1);
            $table->boolean('status')->default(1);
            $table->string('created_by', 50)->nullable()->default('');
            $table->string('modified_by', 50)->nullable()->default('');
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();
            $table->dateTime('dateupdated')->nullable();

            $table->unique(['name', 'slug', 'varian'], 'product_unique');
        });

        Schema::create('product_area_fee', function (Blueprint $table) {
            $table->id();
            $table->string('source', 30)->nullable()->index('paf_source');
            $table->integer('id_source')->index('paf_id_source');
            $table->integer('id_area')->index('paf_id_area');
            $table->double('fee')->default(0);
            $table->boolean('status')->default(1);
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();

            $table->unique(['source', 'id_source', 'id_area'], 'paf_unique');
        });

        Schema::create('product_package', function (Blueprint $table) {
            $table->id();
            $table->string('sku', 200)->nullable();
            $table->string('name', 200);
            $table->string('slug', 255)->nullable();
            $table->string('type', 50)->nullable();
            $table->tinyInteger('hu');
            $table->string('type_price', 50)->nullable();
            $table->integer('total_item');
            $table->integer('total_qty');
            $table->double('total_amount')->default(0);
            $table->double('bv');
            $table->double('price')->default(0);
            $table->double('weight')->nullable()->comment('Weight = Gram');
            $table->double('sponsor_point');
            $table->double('pairing_point');
            $table->double('stockist_point');
            $table->double('reward_point');
            $table->string('image', 255)->nullable()->default('');
            $table->text('description')->nullable();
            $table->tinyInteger('show_order')->default(0);
            $table->boolean('status')->default(1);
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();
            $table->string('created_by', 255)->nullable();
            $table->string('modified_by', 255)->nullable();

            $table->unique(['name', 'slug'], 'pp_unique');
        });

        Schema::create('product_package_item', function (Blueprint $table) {
            $table->id();
            $table->integer('id_package')->index('ppi_package');
            $table->integer('id_product')->index('ppi_product');
            $table->integer('id_varian')->index('ppi_varian');
            $table->integer('qty')->default(0);
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();
        });

        Schema::create('product_stock', function (Blueprint $table) {
            $table->integer('id', true);
            $table->integer('product_id');
            $table->integer('qty');
            $table->double('price');
            $table->double('total');
            $table->string('supplier_name', 100);
            $table->text('description');
            $table->dateTime('datecreated');
            $table->dateTime('datemodified');
            $table->string('created_by', 100)->nullable();
            $table->string('modified_by', 100)->nullable();
        });

        Schema::create('product_stock_in', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_supplier')->index();
            $table->bigInteger('id_warehouse')->index();
            $table->bigInteger('id_source')->index();
            $table->string('source', 20)->comment('bonus, topup, shop, withdraw, transfer')->index();
            $table->bigInteger('id_detail');
            $table->integer('product')->index();
            $table->integer('varian');
            $table->integer('qty');
            $table->boolean('status')->comment('1 = active, 0 = inactive')->index();
            $table->text('description');
            $table->dateTime('datecreated');
            $table->date('dateexpired')->nullable();

            $table->unique(['id_supplier', 'id_warehouse', 'id_source', 'source', 'product', 'varian', 'id_detail'], 'stockin');
        });

        Schema::create('product_stock_opname', function (Blueprint $table) {
            $table->integer('id', true);
            $table->string('ref_number', 50)->index('pso_ref_number');
            $table->integer('product_id')->index('pso_product');
            $table->integer('varian_id');
            $table->integer('recorded_qty');
            $table->integer('actual_qty');
            $table->integer('difference_qty');
            $table->double('price');
            $table->double('total');
            $table->string('type', 10)->nullable();
            $table->string('memo', 50)->nullable();
            $table->text('description')->nullable();
            $table->date('date_trans');
            $table->dateTime('datecreated')->index('pso_date');
            $table->dateTime('datemodified');
            $table->string('created_by', 100)->nullable();
        });

        Schema::create('product_stock_out', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_warehouse')->index();
            $table->bigInteger('id_member')->index();
            $table->bigInteger('id_source')->index();
            $table->string('source', 20)->comment('bonus, topup, shop, withdraw, transfer')->index();
            $table->bigInteger('id_detail');
            $table->integer('product')->index();
            $table->integer('varian');
            $table->integer('qty');
            $table->boolean('status')->comment('1 = active, 0 = inactive')->index();
            $table->text('description');
            $table->dateTime('datecreated');

            $table->unique(['id_member', 'id_source', 'source', 'product', 'varian', 'id_detail', 'id_warehouse'], 'stockout');
        });

        Schema::create('product_stockist', function (Blueprint $table) {
            $table->integer('id', true);
            $table->bigInteger('id_member')->index('pss_id_member');
            $table->bigInteger('id_source')->index('pss_id_source');
            $table->string('source', 20)->comment('bonus, topup, shop, withdraw, transfer')->index('pss_source');
            $table->bigInteger('id_detail')->index('pss_detail');
            $table->integer('product')->index('pss_product');
            $table->integer('varian')->index('pss_varian');
            $table->integer('qty');
            $table->double('price');
            $table->double('total');
            $table->string('form', 50)->nullable()->index('pss_form');
            $table->string('type', 5)->comment('IN, OUT')->index('pss_type');
            $table->tinyInteger('status')->default(1)->comment('1 = active, 0 = inactive')->index('pss_status');
            $table->text('description');
            $table->dateTime('datecreated')->index('pss_datecreated');
            $table->dateTime('datemodified');

            $table->unique(['id_member', 'id_source', 'source', 'id_detail', 'product', 'varian', 'type', 'status'], 'pss_unique');
        });

        Schema::create('product_stockist_stock_opname', function (Blueprint $table) {
            $table->integer('id', true);
            $table->string('ref_number', 50)->index('pso_ref_number');
            $table->bigInteger('id_member')->index('pso_id_member');
            $table->integer('product_id')->index('pso_product');
            $table->integer('varian_id')->index('pso_varian');
            $table->integer('recorded_qty');
            $table->integer('actual_qty');
            $table->integer('difference_qty');
            $table->integer('qty');
            $table->double('price');
            $table->double('total');
            $table->string('type', 10)->nullable();
            $table->string('memo', 50)->nullable();
            $table->text('description')->nullable();
            $table->date('date_trans');
            $table->dateTime('datecreated')->index('pso_date');
            $table->dateTime('datemodified');
            $table->string('created_by', 100)->nullable();
        });

        Schema::create('product_varian', function (Blueprint $table) {
            $table->id();
            $table->integer('id_product')->index('pp_product');
            $table->string('name', 100)->index('pp_name');
            $table->string('varian', 140)->index('pp_varian');
            $table->double('bv')->nullable();
            $table->double('price_hpp')->default(0);
            $table->double('price')->default(0);
            $table->double('weight')->default(0);
            $table->string('image', 255)->nullable();
            $table->boolean('status')->default(1);
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();

            $table->unique(['id_product', 'name', 'varian'], 'pp_unique');
        });

        Schema::create('province', function (Blueprint $table) {
            $table->smallInteger('id')->primary();
            $table->integer('area_id');
            $table->string('province_name', 30);
            $table->string('province_code', 10)->nullable()->default('');
            $table->integer('id_express')->default(0);
        });

        Schema::create('purchase_order', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_purchase_kledo');
            $table->bigInteger('id_purchase_delivery');
            $table->integer('id_supplier_kledo')->nullable();
            $table->string('invoice', 50)->nullable()->default('');
            $table->integer('id_supplier')->index('po_id_supplier');
            $table->string('ref_number_order', 30)->nullable();
            $table->string('ref_number_delivery', 100)->nullable();
            $table->text('products')->nullable();
            $table->integer('total_qty');
            $table->integer('subtotal');
            $table->integer('shipping');
            $table->smallInteger('unique');
            $table->double('pph');
            $table->double('ppn');
            $table->integer('discount');
            $table->integer('down_payment');
            $table->integer('total_payment')->nullable();
            $table->integer('status')->comment('0=Review,1=Confirmed')->index('po_status');
            $table->string('memo', 100)->nullable();
            $table->text('description')->nullable();
            $table->date('trans_date')->nullable();
            $table->date('due_date')->nullable();
            $table->date('delivery_date')->nullable();
            $table->date('dateexpired')->nullable();
            $table->dateTime('datecreated');
            $table->dateTime('datemodified');
            $table->dateTime('dateconfirmed')->nullable();
            $table->string('created_by', 50)->nullable();
            $table->string('modified_by', 50)->nullable();
        });

        Schema::create('purchase_order_detail', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_purchase_order')->index('pod_id_purchase_order');
            $table->integer('id_supplier')->index('pod_id_supplier');
            $table->integer('id_product_kledo');
            $table->integer('id_varian');
            $table->integer('product')->index('pod_product');
            $table->string('name', 255)->nullable();
            $table->string('varian', 200)->nullable();
            $table->string('image', 255)->nullable();
            $table->integer('weight')->comment('Weight = Gram');
            $table->integer('price');
            $table->integer('price_cart');
            $table->integer('qty');
            $table->integer('discount');
            $table->double('pph');
            $table->double('ppn');
            $table->integer('subtotal');
            $table->integer('subtotal_omzet');
            $table->integer('subtotal_weight');
            $table->text('description')->nullable();
            $table->date('dateexpired')->nullable();
            $table->dateTime('datecreated');
            $table->dateTime('datemodified');
        });

        Schema::create('rajaongkir', function (Blueprint $table) {
            $table->integer('id', true);
            $table->integer('province_id')->default(0)->index();
            $table->string('province_name', 200);
            $table->integer('city_id')->default(0)->index();
            $table->string('city_name', 255);
            $table->integer('district_id')->default(0)->index();
            $table->string('district_name', 255);
            $table->integer('id_province')->default(0)->index();
            $table->integer('id_district')->default(0)->index();
            $table->integer('id_subdistrict')->default(0)->index();
        });

        Schema::create('ranks', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member')->index('rk_id_member');
            $table->string('username', 255);
            $table->string('rank', 50)->nullable()->default('')->index('rk_rank');
            $table->tinyInteger('rank_index')->index('rk_index');
            $table->integer('downline');
            $table->double('point_left');
            $table->double('point_right');
            $table->boolean('status')->default(1)->index('rk_status');
            $table->dateTime('datecreated');
            $table->dateTime('datemodified');
        });

        Schema::create('reward', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member')->index('R_id_member');
            $table->integer('id_reward');
            $table->string('type', 50)->nullable();
            $table->bigInteger('point_qualified');
            $table->bigInteger('point_left');
            $table->bigInteger('point_right');
            $table->string('rank', 50)->nullable();
            $table->text('message');
            $table->double('nominal')->default(0);
            $table->double('nominal_receipt');
            $table->double('admin_fund');
            $table->double('tax');
            $table->integer('bank');
            $table->string('bank_code', 20)->nullable()->default('');
            $table->string('bill', 100)->nullable();
            $table->string('bill_name', 100)->nullable();
            $table->tinyInteger('is_trip');
            $table->tinyInteger('claim');
            $table->string('flip_id', 50)->nullable()->default('');
            $table->integer('status')->comment('0=Pending,1=Confirmed');
            $table->string('inquiry_status', 50)->nullable()->default('');
            $table->dateTime('datecreated');
            $table->dateTime('datemodified');
            $table->dateTime('dateconfirmed')->nullable();
            $table->dateTime('dateclaimed')->nullable();
            $table->string('confirm_by', 100)->nullable()->default('');

            $table->unique(['id_member', 'id_reward', 'type'], 'id');
        });

        Schema::create('reward_config', function (Blueprint $table) {
            $table->id();
            $table->string('type', 20);
            $table->string('reward', 200)->default('');
            $table->bigInteger('nominal');
            $table->integer('point');
            $table->text('packages')->nullable();
            $table->string('rank', 100)->nullable();
            $table->text('message')->nullable();
            $table->date('start_date')->nullable();
            $table->date('end_date')->nullable();
            $table->boolean('is_lifetime')->default(1);
            $table->boolean('is_active')->default(1);
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();

            $table->unique(['type', 'reward', 'point', 'start_date', 'end_date', 'is_active'], 'unique_reward');
        });

        Schema::create('reward_point', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member')->index('PP_id_member');
            $table->string('package', 50);
            $table->string('type', 20)->index('PP_type');
            $table->integer('bv');
            $table->double('point');
            $table->integer('status')->default(1);
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();
        });

        Schema::create('ro', function (Blueprint $table) {
            $table->id();
            $table->string('invoice', 50)->nullable()->default('')->index('ro_invoice');
            $table->bigInteger('id_activator')->index('ro_id_activator');
            $table->bigInteger('id_member')->index('ro_id_member');
            $table->bigInteger('id_stockist')->index('ro_id_stockist');
            $table->bigInteger('id_shop_order')->index('ro_id_shop_order');
            $table->string('position', 10)->nullable();
            $table->string('type', 10)->nullable()->default('')->index('ro_type');
            $table->text('pins')->nullable();
            $table->text('meta')->nullable();
            $table->tinyInteger('status')->index('ro_status');
            $table->double('point');
            $table->double('total_bv');
            $table->integer('total_qty');
            $table->double('subtotal');
            $table->smallInteger('unique');
            $table->double('shipping');
            $table->double('shipping_discount');
            $table->double('discount');
            $table->double('voucher');
            $table->double('fee')->default(0);
            $table->double('ppn');
            $table->double('autoro')->default(0);
            $table->double('total_checkout')->default(0);
            $table->double('total_payment');
            $table->double('total_omzet');
            $table->string('shipping_method', 100)->nullable()->default('');
            $table->string('desc', 255)->nullable()->default('');
            $table->dateTime('datecreated')->index('ro_datecreated');
            $table->dateTime('datemodified');
            $table->dateTime('dateconfirmed')->nullable()->index('ro_dateconfirmed');
            $table->string('confirmed_by', 50)->nullable();
            $table->string('modified_by', 50)->nullable();
        });

        Schema::create('ro_point_monthly', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member')->index('RP_id_member');
            $table->smallInteger('year')->index('RP_year');
            $table->tinyInteger('month')->index('RP_month');
            $table->bigInteger('total_bv');
            $table->bigInteger('total_bv_left');
            $table->bigInteger('total_bv_right');
            $table->integer('kurs_bv_point');
            $table->double('point')->default(0);
            $table->double('point_left')->default(0);
            $table->double('point_right')->default(0);
            $table->boolean('status')->default(1)->comment('0=Pending,1=Confirmed');
            $table->text('desc');
            $table->date('date')->nullable()->index('RP_date');
            $table->dateTime('datecreated');
            $table->dateTime('datemodified');

            $table->unique(['id_member', 'year', 'month'], 'RP_unique');
        });

        Schema::create('shop_order', function (Blueprint $table) {
            $table->id();
            $table->string('invoice', 50)->nullable()->default('');
            $table->bigInteger('id_member')->index('po_id_member');
            $table->bigInteger('id_stockist');
            $table->bigInteger('id_espay');
            $table->string('type_order', 20)->nullable();
            $table->text('products')->nullable();
            $table->text('meta')->nullable();
            $table->integer('status')->comment('0=Review,1=Confirmed, 2=done, 4=cancelled')->index('po_status');
            $table->double('point_sponsor');
            $table->double('point_pairing');
            $table->double('point_reward');
            $table->double('point_stockist');
            $table->double('total_bv');
            $table->integer('total_qty');
            $table->double('subtotal');
            $table->double('shipping');
            $table->smallInteger('unique');
            $table->double('discount');
            $table->double('shipping_discount');
            $table->double('fee')->default(0);
            $table->double('ppn');
            $table->double('handling_fee')->default(0);
            $table->double('insurance_fee')->default(0);
            $table->double('additional_cost');
            $table->double('autoro')->default(0);
            $table->double('total_checkout')->default(0);
            $table->double('total_payment');
            $table->integer('payment_remain');
            $table->double('total_omzet');
            $table->double('voucher');
            $table->double('saldo_eproduct');
            $table->double('saldo_eshipping');
            $table->double('saldo_eshipping_subsidy');
            $table->string('payment_method', 100)->nullable()->default('');
            $table->string('payment_shipping_method', 20)->nullable()->default('transfer');
            $table->tinyInteger('payment_shipping_status')->nullable()->default(1);
            $table->string('bank_code', 30)->nullable();
            $table->string('account_number', 100)->nullable();
            $table->string('shipping_method', 100)->nullable()->default('');
            $table->string('name', 255)->nullable();
            $table->string('phone', 20)->nullable();
            $table->string('email', 200)->nullable();
            $table->integer('id_province')->nullable();
            $table->integer('id_district')->nullable();
            $table->integer('id_subdistrict')->nullable();
            $table->string('province', 200)->nullable()->default('');
            $table->string('district', 200)->nullable()->default('');
            $table->string('subdistrict', 200)->nullable()->default('');
            $table->string('village', 200)->nullable();
            $table->text('address')->nullable();
            $table->string('postcode', 8)->nullable()->default('');
            $table->string('courier', 30)->nullable()->default('');
            $table->string('service', 50)->nullable()->default('');
            $table->integer('weight');
            $table->string('resi', 200)->nullable()->default('');
            $table->boolean('pin_transfer')->default(0);
            $table->text('description')->nullable();
            $table->string('created_by', 50)->nullable();
            $table->string('confirmed_by', 50)->nullable();
            $table->string('modified_by', 50)->nullable();
            $table->dateTime('datecreated');
            $table->dateTime('datemodified');
            $table->dateTime('dateconfirmed')->nullable();
            $table->dateTime('datestockistconfirmed')->nullable();
            $table->dateTime('dateexpired')->nullable();
        });

        Schema::create('shop_order_detail', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_shop_order')->index('pod_id_shop_order');
            $table->bigInteger('id_member')->index('pod_id_member');
            $table->integer('product_package')->default(0)->index('pod_id_product_package');
            $table->integer('product')->index('pod_product');
            $table->integer('varian')->default(0)->index('pod_id_varian');
            $table->string('type', 50)->default('');
            $table->integer('weight')->comment('Weight = Gram');
            $table->double('point');
            $table->double('bv');
            $table->double('omzet');
            $table->double('price');
            $table->double('price_cart');
            $table->double('additional_cost');
            $table->integer('qty');
            $table->double('discount');
            $table->double('subtotal');
            $table->double('subtotal_bv');
            $table->double('subtotal_omzet');
            $table->double('subtotal_weight');
            $table->double('subtotal_cost');
            $table->dateTime('datecreated');
            $table->dateTime('datemodified');
        });

        Schema::create('staff', function (Blueprint $table) {
            $table->id();
            $table->string('username', 50)->unique();
            $table->string('password', 100);
            $table->string('name', 100);
            $table->string('email', 50)->index();
            $table->string('phone', 20);
            $table->string('photo', 255)->nullable()->default('');
            $table->string('access', 10);
            $table->text('role')->nullable();
            $table->tinyInteger('status')->nullable()->default(1);
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();
        });

        Schema::create('subdistrict', function (Blueprint $table) {
            $table->integer('id', true);
            $table->smallInteger('district_id');
            $table->string('subdistrict_name', 30);
            $table->integer('id_express');
            $table->string('lion', 255)->nullable();
        });

        Schema::create('supplier', function (Blueprint $table) {
            $table->id();
            $table->string('name', 100)->unique();
            $table->string('email', 50)->nullable()->index();
            $table->string('phone', 20)->nullable();
            $table->text('address')->nullable();
            $table->integer('id_contact_kledo')->nullable();
            $table->boolean('status')->nullable()->default(1);
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();
        });

        Schema::create('upgrade', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('upgrader')->nullable()->default(0);
            $table->bigInteger('id_member')->default(0)->index();
            $table->string('package_before', 50);
            $table->string('package_after', 50);
            $table->string('upgrade', 100);
            $table->bigInteger('omzet')->default(0);
            $table->bigInteger('amount')->default(0);
            $table->smallInteger('point')->default(0);
            $table->text('pins')->nullable();
            $table->text('desc')->nullable();
            $table->dateTime('datecreated');
            $table->dateTime('datemodified');
        });

        Schema::create('video', function (Blueprint $table) {
            $table->id();
            $table->text('title');
            $table->text('url');
            $table->integer('sequence');
            $table->text('image');
            $table->boolean('status')->default(1);
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();
        });

        Schema::create('video_progress', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('id_member');
            $table->bigInteger('id_video');
            $table->boolean('status')->default(1);
            $table->dateTime('datecreated');
            $table->dateTime('datemodified')->nullable();
        });

        Schema::create('withdraw', function (Blueprint $table) {
            $table->integer('id', true);
            $table->bigInteger('id_member')->index('wd_id_member');
            $table->string('type', 30)->nullable()->index('wd_type');
            $table->integer('bank');
            $table->string('bank_type', 50)->nullable();
            $table->string('bank_code', 20)->nullable()->default('');
            $table->string('bank_name', 150)->nullable();
            $table->string('bill', 100);
            $table->string('bill_name', 100);
            $table->integer('nominal');
            $table->integer('nominal_receipt');
            $table->integer('tax');
            $table->integer('auto_ro');
            $table->integer('admin_fund');
            $table->tinyInteger('status')->nullable()->default(0)->index('wd_status');
            $table->string('flip_id', 50)->nullable()->default('');
            $table->string('linkita_inquiry', 100)->nullable()->index('wd_linkita_inquiry');
            $table->string('inquiry_status', 100)->nullable()->default('');
            $table->string('linkita_pay', 100)->nullable()->index('wd_linkita_pay');
            $table->string('payment_status', 100)->nullable()->default('');
            $table->dateTime('datecreated')->index('wd_date');
            $table->dateTime('datemodified');
            $table->dateTime('dateconfirmed')->nullable();
            $table->string('confirm_by', 50)->nullable()->default('');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Drop tables in reverse order or just all of them
        Schema::dropIfExists('withdraw');
        Schema::dropIfExists('video_progress');
        Schema::dropIfExists('video');
        Schema::dropIfExists('upgrade');
        Schema::dropIfExists('supplier');
        Schema::dropIfExists('subdistrict');
        Schema::dropIfExists('staff');
        Schema::dropIfExists('shop_order_detail');
        Schema::dropIfExists('shop_order');
        Schema::dropIfExists('ro_point_monthly');
        Schema::dropIfExists('ro');
        Schema::dropIfExists('reward_point');
        Schema::dropIfExists('reward_config');
        Schema::dropIfExists('reward');
        Schema::dropIfExists('ranks');
        Schema::dropIfExists('rajaongkir');
        Schema::dropIfExists('purchase_order_detail');
        Schema::dropIfExists('purchase_order');
        Schema::dropIfExists('province');
        Schema::dropIfExists('product_varian');
        Schema::dropIfExists('product_stockist_stock_opname');
        Schema::dropIfExists('product_stockist');
        Schema::dropIfExists('product_stock_out');
        Schema::dropIfExists('product_stock_opname');
        Schema::dropIfExists('product_stock_in');
        Schema::dropIfExists('product_stock');
        Schema::dropIfExists('product_package_item');
        Schema::dropIfExists('product_package');
        Schema::dropIfExists('product_area_fee');
        Schema::dropIfExists('product');
        Schema::dropIfExists('pin_transfer');
        Schema::dropIfExists('pin');
        Schema::dropIfExists('pairing_qualified');
        Schema::dropIfExists('pairing_point');
        Schema::dropIfExists('package');
        Schema::dropIfExists('otp');
        Schema::dropIfExists('options');
        Schema::dropIfExists('notification');
        Schema::dropIfExists('news');
        Schema::dropIfExists('member_report');
        Schema::dropIfExists('member_point');
        Schema::dropIfExists('member_omzet');
        Schema::dropIfExists('member_confirm');
        Schema::dropIfExists('log_notif');
        Schema::dropIfExists('log_cron');
        Schema::dropIfExists('log_api');
        Schema::dropIfExists('log_action');
        Schema::dropIfExists('log');
        Schema::dropIfExists('keys');
        Schema::dropIfExists('ewallet_transfer');
        Schema::dropIfExists('ewallet');
        Schema::dropIfExists('eproduct');
        Schema::dropIfExists('district');
        Schema::dropIfExists('country');
        Schema::dropIfExists('cart');
        Schema::dropIfExists('bonus_matching_refs');
        Schema::dropIfExists('bonus_level_refs');
        Schema::dropIfExists('bonus_generation_refs');
        Schema::dropIfExists('bonus');
        Schema::dropIfExists('banks');
        Schema::dropIfExists('auto_ro_out');
        Schema::dropIfExists('auto_ro');
        Schema::dropIfExists('area');
    }
};
