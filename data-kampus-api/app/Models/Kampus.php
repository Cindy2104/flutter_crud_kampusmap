<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Kampus extends Model
{
    protected $table = 'kampus';
    protected $fillable = ['nama', 'alamat', 'no_telp', 'kategori', 'latitude', 'longitude', 'jurusan'];
}
