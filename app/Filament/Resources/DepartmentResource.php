<?php

namespace App\Filament\Resources;

use App\Models\Department;
use Filament\Forms;
use Filament\Forms\Components\TextInput;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Columns\TextColumn;
use App\Filament\Resources\DepartmentResource\Pages;

class DepartmentResource extends Resource
{
    protected static ?string $model = Department::class;
    protected static ?string $navigationLabel = 'Bộ môn';
    protected static ?string $pluralLabel = 'Bộ môn';
    protected static ?string $navigationIcon = 'heroicon-o-academic-cap';
    // Thêm dòng này để nhóm Resource lại
    protected static ?string $navigationGroup = 'Resources'; // Tên nhóm bạn muốn

    public static function form(Forms\Form $form): Forms\Form
    {
        return $form->schema([
            TextInput::make('name')
                ->label('Tên bộ môn')
                ->required(),
        ]);
    }

    public static function table(Tables\Table $table): Tables\Table
    {
        return $table->columns([
            // TextColumn::make('id')->sortable(),
            TextColumn::make('name')->label('Tên bộ môn')->sortable(),
            // TextColumn::make('created_at')->label('Ngày tạo')->dateTime(),
            TextColumn::make('subjects_count')
                ->label('Số môn học')
                ->counts('subjects')
                ->sortable(), // Đếm số môn học của bộ môn
        ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListDepartments::route('/'),
            'create' => Pages\CreateDepartment::route('/create'),
            'edit' => Pages\EditDepartment::route('/{record}/edit'),
        ];
    }
}
