<?php

namespace App\Filament\Resources\PersonalInfoResource\Pages;

use App\Filament\Resources\PersonalInfoResource;
use Filament\Resources\Pages\Page;

class RegisterCourse extends Page
{
    protected static string $resource = PersonalInfoResource::class;

    protected static string $view = 'filament.resources.personal-info-resource.pages.register-course';
}
