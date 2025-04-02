<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ResourceResource\Pages;
use App\Filament\Resources\ResourceResource\RelationManagers;
use App\Models\Resource as ResourceModel;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Resources\Resource as FilamentResource;

class ResourceResource extends Resource
{
    protected static ?string $model = ResourceModel::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    protected static ?int $navigationSort = 4; // Ví dụ: đặt ở vị trí số 5

    public static function form(Form $form): Form
    {
        return $form
        ->schema([
            TextInput::make('appname')
                ->label('Tên ứng dụng')
                ->required(),
            TextInput::make('version')
                ->label('Phiên bản')
                ->nullable(),
            TextInput::make('link_truycap')
                ->label('Link truy cập')
                ->url() // Kiểm tra định dạng URL
                ->required(),
            TextInput::make('ten_hanhdong')
                ->label('Tên hành động')
                ->required(),
            Toggle::make('trangthai_link')
                ->label('Trạng thái link')
                ->default(true),
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
        ->columns([
            // Định nghĩa các cột trong danh sách (table)
            Tables\Columns\TextColumn::make('id'),
            Tables\Columns\TextColumn::make('appname'),
            Tables\Columns\TextColumn::make('version'),
            // Tables\Columns\TextColumn::make('link_truycap'),
            Tables\Columns\TextColumn::make('ten_hanhdong'),
            Tables\Columns\BooleanColumn::make('trangthai_link'),
        ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListResources::route('/'),
            'create' => Pages\CreateResource::route('/create'),
            'edit' => Pages\EditResource::route('/{record}/edit'),
        ];
    }
}
