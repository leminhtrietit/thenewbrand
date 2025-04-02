<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Department; // Thêm dòng này


class DepartmentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        //
        $departments = ['Tin học văn phòng','Kế toán','Đồ họa','Vẽ kỹ thuật','Lập trình'];

        foreach ($departments as $department) {
            Department::create(['name' => $department]);
        }
    }
}
