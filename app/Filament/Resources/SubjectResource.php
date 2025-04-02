<?php

namespace App\Filament\Resources;

use App\Models\Subject;
use App\Models\Department;
use Filament\Forms;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput\Mask;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Columns\TextColumn;
use App\Filament\Resources\SubjectResource\Pages;

class SubjectResource extends Resource
{
    protected static ?string $model = Subject::class;
    protected static ?string $navigationLabel = 'Môn học';
    protected static ?string $pluralLabel = 'Môn học';
    protected static ?string $navigationIcon = 'heroicon-o-book-open';
    protected static ?string $navigationGroup = 'Resources'; // Tên nhóm bạn muốn

    public static function form(Forms\Form $form): Forms\Form
    {
        return $form->schema([
            TextInput::make('name')->label('Tên môn học')->required(),
            Select::make('department_id')
                ->label('Bộ môn')
                ->options(Department::pluck('name', 'id'))
                ->searchable()
                ->required(),
            TextInput::make('price')
                ->label('Giá tiền (VND)')
                ->formatStateUsing(fn ($state) => number_format($state, 0, ',', '.'))
                ->extraInputAttributes([
                    'oninput' => "this.value = this.value.replace(/\D/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, '.');"            ])
                ->dehydrateStateUsing(fn ($state) => (float) str_replace('.', '', $state))
                ->required()
        ]);
    }

    public static function table(Tables\Table $table): Tables\Table
    {
        return $table->columns([
            // TextColumn::make('id')->sortable(),
            TextColumn::make('name')->label('Tên môn học')->sortable(),
            TextColumn::make('department.name')->label('Bộ môn')->sortable(),
            TextColumn::make('price')->label('Giá tiền')->money('VND')->sortable(),
            // TextColumn::make('created_at')->label('Ngày tạo')->dateTime(),
        ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListSubjects::route('/'),
            'create' => Pages\CreateSubject::route('/create'),
            'edit' => Pages\EditSubject::route('/{record}/edit'),
        ];
    }
}
