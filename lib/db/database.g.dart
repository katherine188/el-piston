// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ClientesTable extends Clientes with TableInfo<$ClientesTable, Cliente> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _telefonoMeta =
      const VerificationMeta('telefono');
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
      'telefono', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _direccionMeta =
      const VerificationMeta('direccion');
  @override
  late final GeneratedColumn<String> direccion = GeneratedColumn<String>(
      'direccion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, nombre, telefono, direccion];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clientes';
  @override
  VerificationContext validateIntegrity(Insertable<Cliente> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('telefono')) {
      context.handle(_telefonoMeta,
          telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta));
    } else if (isInserting) {
      context.missing(_telefonoMeta);
    }
    if (data.containsKey('direccion')) {
      context.handle(_direccionMeta,
          direccion.isAcceptableOrUnknown(data['direccion']!, _direccionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Cliente map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cliente(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      telefono: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefono'])!,
      direccion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}direccion']),
    );
  }

  @override
  $ClientesTable createAlias(String alias) {
    return $ClientesTable(attachedDatabase, alias);
  }
}

class Cliente extends DataClass implements Insertable<Cliente> {
  final int id;
  final String nombre;
  final String telefono;
  final String? direccion;
  const Cliente(
      {required this.id,
      required this.nombre,
      required this.telefono,
      this.direccion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['telefono'] = Variable<String>(telefono);
    if (!nullToAbsent || direccion != null) {
      map['direccion'] = Variable<String>(direccion);
    }
    return map;
  }

  ClientesCompanion toCompanion(bool nullToAbsent) {
    return ClientesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      telefono: Value(telefono),
      direccion: direccion == null && nullToAbsent
          ? const Value.absent()
          : Value(direccion),
    );
  }

  factory Cliente.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cliente(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      telefono: serializer.fromJson<String>(json['telefono']),
      direccion: serializer.fromJson<String?>(json['direccion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'telefono': serializer.toJson<String>(telefono),
      'direccion': serializer.toJson<String?>(direccion),
    };
  }

  Cliente copyWith(
          {int? id,
          String? nombre,
          String? telefono,
          Value<String?> direccion = const Value.absent()}) =>
      Cliente(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        telefono: telefono ?? this.telefono,
        direccion: direccion.present ? direccion.value : this.direccion,
      );
  Cliente copyWithCompanion(ClientesCompanion data) {
    return Cliente(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      direccion: data.direccion.present ? data.direccion.value : this.direccion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cliente(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('telefono: $telefono, ')
          ..write('direccion: $direccion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, telefono, direccion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cliente &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.telefono == this.telefono &&
          other.direccion == this.direccion);
}

class ClientesCompanion extends UpdateCompanion<Cliente> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> telefono;
  final Value<String?> direccion;
  const ClientesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.telefono = const Value.absent(),
    this.direccion = const Value.absent(),
  });
  ClientesCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String telefono,
    this.direccion = const Value.absent(),
  })  : nombre = Value(nombre),
        telefono = Value(telefono);
  static Insertable<Cliente> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? telefono,
    Expression<String>? direccion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (telefono != null) 'telefono': telefono,
      if (direccion != null) 'direccion': direccion,
    });
  }

  ClientesCompanion copyWith(
      {Value<int>? id,
      Value<String>? nombre,
      Value<String>? telefono,
      Value<String?>? direccion}) {
    return ClientesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      direccion: direccion ?? this.direccion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (direccion.present) {
      map['direccion'] = Variable<String>(direccion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('telefono: $telefono, ')
          ..write('direccion: $direccion')
          ..write(')'))
        .toString();
  }
}

class $VehiculosTable extends Vehiculos
    with TableInfo<$VehiculosTable, Vehiculo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiculosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _clienteIdMeta =
      const VerificationMeta('clienteId');
  @override
  late final GeneratedColumn<int> clienteId = GeneratedColumn<int>(
      'cliente_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _matriculaMeta =
      const VerificationMeta('matricula');
  @override
  late final GeneratedColumn<String> matricula = GeneratedColumn<String>(
      'matricula', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _marcaMeta = const VerificationMeta('marca');
  @override
  late final GeneratedColumn<String> marca = GeneratedColumn<String>(
      'marca', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modeloMeta = const VerificationMeta('modelo');
  @override
  late final GeneratedColumn<String> modelo = GeneratedColumn<String>(
      'modelo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _anioMeta = const VerificationMeta('anio');
  @override
  late final GeneratedColumn<int> anio = GeneratedColumn<int>(
      'anio', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _kmMeta = const VerificationMeta('km');
  @override
  late final GeneratedColumn<int> km = GeneratedColumn<int>(
      'km', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, clienteId, matricula, marca, modelo, anio, km];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehiculos';
  @override
  VerificationContext validateIntegrity(Insertable<Vehiculo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cliente_id')) {
      context.handle(_clienteIdMeta,
          clienteId.isAcceptableOrUnknown(data['cliente_id']!, _clienteIdMeta));
    } else if (isInserting) {
      context.missing(_clienteIdMeta);
    }
    if (data.containsKey('matricula')) {
      context.handle(_matriculaMeta,
          matricula.isAcceptableOrUnknown(data['matricula']!, _matriculaMeta));
    } else if (isInserting) {
      context.missing(_matriculaMeta);
    }
    if (data.containsKey('marca')) {
      context.handle(
          _marcaMeta, marca.isAcceptableOrUnknown(data['marca']!, _marcaMeta));
    } else if (isInserting) {
      context.missing(_marcaMeta);
    }
    if (data.containsKey('modelo')) {
      context.handle(_modeloMeta,
          modelo.isAcceptableOrUnknown(data['modelo']!, _modeloMeta));
    } else if (isInserting) {
      context.missing(_modeloMeta);
    }
    if (data.containsKey('anio')) {
      context.handle(
          _anioMeta, anio.isAcceptableOrUnknown(data['anio']!, _anioMeta));
    } else if (isInserting) {
      context.missing(_anioMeta);
    }
    if (data.containsKey('km')) {
      context.handle(_kmMeta, km.isAcceptableOrUnknown(data['km']!, _kmMeta));
    } else if (isInserting) {
      context.missing(_kmMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vehiculo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vehiculo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      clienteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cliente_id'])!,
      matricula: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}matricula'])!,
      marca: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}marca'])!,
      modelo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}modelo'])!,
      anio: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}anio'])!,
      km: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}km'])!,
    );
  }

  @override
  $VehiculosTable createAlias(String alias) {
    return $VehiculosTable(attachedDatabase, alias);
  }
}

class Vehiculo extends DataClass implements Insertable<Vehiculo> {
  final int id;
  final int clienteId;
  final String matricula;
  final String marca;
  final String modelo;
  final int anio;
  final int km;
  const Vehiculo(
      {required this.id,
      required this.clienteId,
      required this.matricula,
      required this.marca,
      required this.modelo,
      required this.anio,
      required this.km});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cliente_id'] = Variable<int>(clienteId);
    map['matricula'] = Variable<String>(matricula);
    map['marca'] = Variable<String>(marca);
    map['modelo'] = Variable<String>(modelo);
    map['anio'] = Variable<int>(anio);
    map['km'] = Variable<int>(km);
    return map;
  }

  VehiculosCompanion toCompanion(bool nullToAbsent) {
    return VehiculosCompanion(
      id: Value(id),
      clienteId: Value(clienteId),
      matricula: Value(matricula),
      marca: Value(marca),
      modelo: Value(modelo),
      anio: Value(anio),
      km: Value(km),
    );
  }

  factory Vehiculo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vehiculo(
      id: serializer.fromJson<int>(json['id']),
      clienteId: serializer.fromJson<int>(json['clienteId']),
      matricula: serializer.fromJson<String>(json['matricula']),
      marca: serializer.fromJson<String>(json['marca']),
      modelo: serializer.fromJson<String>(json['modelo']),
      anio: serializer.fromJson<int>(json['anio']),
      km: serializer.fromJson<int>(json['km']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clienteId': serializer.toJson<int>(clienteId),
      'matricula': serializer.toJson<String>(matricula),
      'marca': serializer.toJson<String>(marca),
      'modelo': serializer.toJson<String>(modelo),
      'anio': serializer.toJson<int>(anio),
      'km': serializer.toJson<int>(km),
    };
  }

  Vehiculo copyWith(
          {int? id,
          int? clienteId,
          String? matricula,
          String? marca,
          String? modelo,
          int? anio,
          int? km}) =>
      Vehiculo(
        id: id ?? this.id,
        clienteId: clienteId ?? this.clienteId,
        matricula: matricula ?? this.matricula,
        marca: marca ?? this.marca,
        modelo: modelo ?? this.modelo,
        anio: anio ?? this.anio,
        km: km ?? this.km,
      );
  Vehiculo copyWithCompanion(VehiculosCompanion data) {
    return Vehiculo(
      id: data.id.present ? data.id.value : this.id,
      clienteId: data.clienteId.present ? data.clienteId.value : this.clienteId,
      matricula: data.matricula.present ? data.matricula.value : this.matricula,
      marca: data.marca.present ? data.marca.value : this.marca,
      modelo: data.modelo.present ? data.modelo.value : this.modelo,
      anio: data.anio.present ? data.anio.value : this.anio,
      km: data.km.present ? data.km.value : this.km,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vehiculo(')
          ..write('id: $id, ')
          ..write('clienteId: $clienteId, ')
          ..write('matricula: $matricula, ')
          ..write('marca: $marca, ')
          ..write('modelo: $modelo, ')
          ..write('anio: $anio, ')
          ..write('km: $km')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, clienteId, matricula, marca, modelo, anio, km);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vehiculo &&
          other.id == this.id &&
          other.clienteId == this.clienteId &&
          other.matricula == this.matricula &&
          other.marca == this.marca &&
          other.modelo == this.modelo &&
          other.anio == this.anio &&
          other.km == this.km);
}

class VehiculosCompanion extends UpdateCompanion<Vehiculo> {
  final Value<int> id;
  final Value<int> clienteId;
  final Value<String> matricula;
  final Value<String> marca;
  final Value<String> modelo;
  final Value<int> anio;
  final Value<int> km;
  const VehiculosCompanion({
    this.id = const Value.absent(),
    this.clienteId = const Value.absent(),
    this.matricula = const Value.absent(),
    this.marca = const Value.absent(),
    this.modelo = const Value.absent(),
    this.anio = const Value.absent(),
    this.km = const Value.absent(),
  });
  VehiculosCompanion.insert({
    this.id = const Value.absent(),
    required int clienteId,
    required String matricula,
    required String marca,
    required String modelo,
    required int anio,
    required int km,
  })  : clienteId = Value(clienteId),
        matricula = Value(matricula),
        marca = Value(marca),
        modelo = Value(modelo),
        anio = Value(anio),
        km = Value(km);
  static Insertable<Vehiculo> custom({
    Expression<int>? id,
    Expression<int>? clienteId,
    Expression<String>? matricula,
    Expression<String>? marca,
    Expression<String>? modelo,
    Expression<int>? anio,
    Expression<int>? km,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clienteId != null) 'cliente_id': clienteId,
      if (matricula != null) 'matricula': matricula,
      if (marca != null) 'marca': marca,
      if (modelo != null) 'modelo': modelo,
      if (anio != null) 'anio': anio,
      if (km != null) 'km': km,
    });
  }

  VehiculosCompanion copyWith(
      {Value<int>? id,
      Value<int>? clienteId,
      Value<String>? matricula,
      Value<String>? marca,
      Value<String>? modelo,
      Value<int>? anio,
      Value<int>? km}) {
    return VehiculosCompanion(
      id: id ?? this.id,
      clienteId: clienteId ?? this.clienteId,
      matricula: matricula ?? this.matricula,
      marca: marca ?? this.marca,
      modelo: modelo ?? this.modelo,
      anio: anio ?? this.anio,
      km: km ?? this.km,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clienteId.present) {
      map['cliente_id'] = Variable<int>(clienteId.value);
    }
    if (matricula.present) {
      map['matricula'] = Variable<String>(matricula.value);
    }
    if (marca.present) {
      map['marca'] = Variable<String>(marca.value);
    }
    if (modelo.present) {
      map['modelo'] = Variable<String>(modelo.value);
    }
    if (anio.present) {
      map['anio'] = Variable<int>(anio.value);
    }
    if (km.present) {
      map['km'] = Variable<int>(km.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiculosCompanion(')
          ..write('id: $id, ')
          ..write('clienteId: $clienteId, ')
          ..write('matricula: $matricula, ')
          ..write('marca: $marca, ')
          ..write('modelo: $modelo, ')
          ..write('anio: $anio, ')
          ..write('km: $km')
          ..write(')'))
        .toString();
  }
}

class $MecanicosTable extends Mecanicos
    with TableInfo<$MecanicosTable, Mecanico> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MecanicosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, nombre];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mecanicos';
  @override
  VerificationContext validateIntegrity(Insertable<Mecanico> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Mecanico map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Mecanico(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
    );
  }

  @override
  $MecanicosTable createAlias(String alias) {
    return $MecanicosTable(attachedDatabase, alias);
  }
}

class Mecanico extends DataClass implements Insertable<Mecanico> {
  final int id;
  final String nombre;
  const Mecanico({required this.id, required this.nombre});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    return map;
  }

  MecanicosCompanion toCompanion(bool nullToAbsent) {
    return MecanicosCompanion(
      id: Value(id),
      nombre: Value(nombre),
    );
  }

  factory Mecanico.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Mecanico(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
    };
  }

  Mecanico copyWith({int? id, String? nombre}) => Mecanico(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
      );
  Mecanico copyWithCompanion(MecanicosCompanion data) {
    return Mecanico(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Mecanico(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Mecanico && other.id == this.id && other.nombre == this.nombre);
}

class MecanicosCompanion extends UpdateCompanion<Mecanico> {
  final Value<int> id;
  final Value<String> nombre;
  const MecanicosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
  });
  MecanicosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
  }) : nombre = Value(nombre);
  static Insertable<Mecanico> custom({
    Expression<int>? id,
    Expression<String>? nombre,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
    });
  }

  MecanicosCompanion copyWith({Value<int>? id, Value<String>? nombre}) {
    return MecanicosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MecanicosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }
}

class $OrdenesTable extends Ordenes with TableInfo<$OrdenesTable, Orden> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdenesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _vehiculoIdMeta =
      const VerificationMeta('vehiculoId');
  @override
  late final GeneratedColumn<int> vehiculoId = GeneratedColumn<int>(
      'vehiculo_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _mecanicoIdMeta =
      const VerificationMeta('mecanicoId');
  @override
  late final GeneratedColumn<int> mecanicoId = GeneratedColumn<int>(
      'mecanico_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _fechaEntradaMeta =
      const VerificationMeta('fechaEntrada');
  @override
  late final GeneratedColumn<DateTime> fechaEntrada = GeneratedColumn<DateTime>(
      'fecha_entrada', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _problemaMeta =
      const VerificationMeta('problema');
  @override
  late final GeneratedColumn<String> problema = GeneratedColumn<String>(
      'problema', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<Estado, String> estado =
      GeneratedColumn<String>('estado', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Estado>($OrdenesTable.$converterestado);
  static const VerificationMeta _kmIngresoMeta =
      const VerificationMeta('kmIngreso');
  @override
  late final GeneratedColumn<int> kmIngreso = GeneratedColumn<int>(
      'km_ingreso', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, vehiculoId, mecanicoId, fechaEntrada, problema, estado, kmIngreso];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ordenes';
  @override
  VerificationContext validateIntegrity(Insertable<Orden> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehiculo_id')) {
      context.handle(
          _vehiculoIdMeta,
          vehiculoId.isAcceptableOrUnknown(
              data['vehiculo_id']!, _vehiculoIdMeta));
    } else if (isInserting) {
      context.missing(_vehiculoIdMeta);
    }
    if (data.containsKey('mecanico_id')) {
      context.handle(
          _mecanicoIdMeta,
          mecanicoId.isAcceptableOrUnknown(
              data['mecanico_id']!, _mecanicoIdMeta));
    } else if (isInserting) {
      context.missing(_mecanicoIdMeta);
    }
    if (data.containsKey('fecha_entrada')) {
      context.handle(
          _fechaEntradaMeta,
          fechaEntrada.isAcceptableOrUnknown(
              data['fecha_entrada']!, _fechaEntradaMeta));
    } else if (isInserting) {
      context.missing(_fechaEntradaMeta);
    }
    if (data.containsKey('problema')) {
      context.handle(_problemaMeta,
          problema.isAcceptableOrUnknown(data['problema']!, _problemaMeta));
    } else if (isInserting) {
      context.missing(_problemaMeta);
    }
    if (data.containsKey('km_ingreso')) {
      context.handle(_kmIngresoMeta,
          kmIngreso.isAcceptableOrUnknown(data['km_ingreso']!, _kmIngresoMeta));
    } else if (isInserting) {
      context.missing(_kmIngresoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Orden map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Orden(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      vehiculoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vehiculo_id'])!,
      mecanicoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mecanico_id'])!,
      fechaEntrada: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_entrada'])!,
      problema: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}problema'])!,
      estado: $OrdenesTable.$converterestado.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado'])!),
      kmIngreso: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}km_ingreso'])!,
    );
  }

  @override
  $OrdenesTable createAlias(String alias) {
    return $OrdenesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Estado, String, String> $converterestado =
      const EnumNameConverter<Estado>(Estado.values);
}

class Orden extends DataClass implements Insertable<Orden> {
  final int id;
  final int vehiculoId;
  final int mecanicoId;
  final DateTime fechaEntrada;
  final String problema;
  final Estado estado;
  final int kmIngreso;
  const Orden(
      {required this.id,
      required this.vehiculoId,
      required this.mecanicoId,
      required this.fechaEntrada,
      required this.problema,
      required this.estado,
      required this.kmIngreso});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehiculo_id'] = Variable<int>(vehiculoId);
    map['mecanico_id'] = Variable<int>(mecanicoId);
    map['fecha_entrada'] = Variable<DateTime>(fechaEntrada);
    map['problema'] = Variable<String>(problema);
    {
      map['estado'] =
          Variable<String>($OrdenesTable.$converterestado.toSql(estado));
    }
    map['km_ingreso'] = Variable<int>(kmIngreso);
    return map;
  }

  OrdenesCompanion toCompanion(bool nullToAbsent) {
    return OrdenesCompanion(
      id: Value(id),
      vehiculoId: Value(vehiculoId),
      mecanicoId: Value(mecanicoId),
      fechaEntrada: Value(fechaEntrada),
      problema: Value(problema),
      estado: Value(estado),
      kmIngreso: Value(kmIngreso),
    );
  }

  factory Orden.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Orden(
      id: serializer.fromJson<int>(json['id']),
      vehiculoId: serializer.fromJson<int>(json['vehiculoId']),
      mecanicoId: serializer.fromJson<int>(json['mecanicoId']),
      fechaEntrada: serializer.fromJson<DateTime>(json['fechaEntrada']),
      problema: serializer.fromJson<String>(json['problema']),
      estado: $OrdenesTable.$converterestado
          .fromJson(serializer.fromJson<String>(json['estado'])),
      kmIngreso: serializer.fromJson<int>(json['kmIngreso']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehiculoId': serializer.toJson<int>(vehiculoId),
      'mecanicoId': serializer.toJson<int>(mecanicoId),
      'fechaEntrada': serializer.toJson<DateTime>(fechaEntrada),
      'problema': serializer.toJson<String>(problema),
      'estado': serializer
          .toJson<String>($OrdenesTable.$converterestado.toJson(estado)),
      'kmIngreso': serializer.toJson<int>(kmIngreso),
    };
  }

  Orden copyWith(
          {int? id,
          int? vehiculoId,
          int? mecanicoId,
          DateTime? fechaEntrada,
          String? problema,
          Estado? estado,
          int? kmIngreso}) =>
      Orden(
        id: id ?? this.id,
        vehiculoId: vehiculoId ?? this.vehiculoId,
        mecanicoId: mecanicoId ?? this.mecanicoId,
        fechaEntrada: fechaEntrada ?? this.fechaEntrada,
        problema: problema ?? this.problema,
        estado: estado ?? this.estado,
        kmIngreso: kmIngreso ?? this.kmIngreso,
      );
  Orden copyWithCompanion(OrdenesCompanion data) {
    return Orden(
      id: data.id.present ? data.id.value : this.id,
      vehiculoId:
          data.vehiculoId.present ? data.vehiculoId.value : this.vehiculoId,
      mecanicoId:
          data.mecanicoId.present ? data.mecanicoId.value : this.mecanicoId,
      fechaEntrada: data.fechaEntrada.present
          ? data.fechaEntrada.value
          : this.fechaEntrada,
      problema: data.problema.present ? data.problema.value : this.problema,
      estado: data.estado.present ? data.estado.value : this.estado,
      kmIngreso: data.kmIngreso.present ? data.kmIngreso.value : this.kmIngreso,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Orden(')
          ..write('id: $id, ')
          ..write('vehiculoId: $vehiculoId, ')
          ..write('mecanicoId: $mecanicoId, ')
          ..write('fechaEntrada: $fechaEntrada, ')
          ..write('problema: $problema, ')
          ..write('estado: $estado, ')
          ..write('kmIngreso: $kmIngreso')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, vehiculoId, mecanicoId, fechaEntrada, problema, estado, kmIngreso);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Orden &&
          other.id == this.id &&
          other.vehiculoId == this.vehiculoId &&
          other.mecanicoId == this.mecanicoId &&
          other.fechaEntrada == this.fechaEntrada &&
          other.problema == this.problema &&
          other.estado == this.estado &&
          other.kmIngreso == this.kmIngreso);
}

class OrdenesCompanion extends UpdateCompanion<Orden> {
  final Value<int> id;
  final Value<int> vehiculoId;
  final Value<int> mecanicoId;
  final Value<DateTime> fechaEntrada;
  final Value<String> problema;
  final Value<Estado> estado;
  final Value<int> kmIngreso;
  const OrdenesCompanion({
    this.id = const Value.absent(),
    this.vehiculoId = const Value.absent(),
    this.mecanicoId = const Value.absent(),
    this.fechaEntrada = const Value.absent(),
    this.problema = const Value.absent(),
    this.estado = const Value.absent(),
    this.kmIngreso = const Value.absent(),
  });
  OrdenesCompanion.insert({
    this.id = const Value.absent(),
    required int vehiculoId,
    required int mecanicoId,
    required DateTime fechaEntrada,
    required String problema,
    required Estado estado,
    required int kmIngreso,
  })  : vehiculoId = Value(vehiculoId),
        mecanicoId = Value(mecanicoId),
        fechaEntrada = Value(fechaEntrada),
        problema = Value(problema),
        estado = Value(estado),
        kmIngreso = Value(kmIngreso);
  static Insertable<Orden> custom({
    Expression<int>? id,
    Expression<int>? vehiculoId,
    Expression<int>? mecanicoId,
    Expression<DateTime>? fechaEntrada,
    Expression<String>? problema,
    Expression<String>? estado,
    Expression<int>? kmIngreso,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehiculoId != null) 'vehiculo_id': vehiculoId,
      if (mecanicoId != null) 'mecanico_id': mecanicoId,
      if (fechaEntrada != null) 'fecha_entrada': fechaEntrada,
      if (problema != null) 'problema': problema,
      if (estado != null) 'estado': estado,
      if (kmIngreso != null) 'km_ingreso': kmIngreso,
    });
  }

  OrdenesCompanion copyWith(
      {Value<int>? id,
      Value<int>? vehiculoId,
      Value<int>? mecanicoId,
      Value<DateTime>? fechaEntrada,
      Value<String>? problema,
      Value<Estado>? estado,
      Value<int>? kmIngreso}) {
    return OrdenesCompanion(
      id: id ?? this.id,
      vehiculoId: vehiculoId ?? this.vehiculoId,
      mecanicoId: mecanicoId ?? this.mecanicoId,
      fechaEntrada: fechaEntrada ?? this.fechaEntrada,
      problema: problema ?? this.problema,
      estado: estado ?? this.estado,
      kmIngreso: kmIngreso ?? this.kmIngreso,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehiculoId.present) {
      map['vehiculo_id'] = Variable<int>(vehiculoId.value);
    }
    if (mecanicoId.present) {
      map['mecanico_id'] = Variable<int>(mecanicoId.value);
    }
    if (fechaEntrada.present) {
      map['fecha_entrada'] = Variable<DateTime>(fechaEntrada.value);
    }
    if (problema.present) {
      map['problema'] = Variable<String>(problema.value);
    }
    if (estado.present) {
      map['estado'] =
          Variable<String>($OrdenesTable.$converterestado.toSql(estado.value));
    }
    if (kmIngreso.present) {
      map['km_ingreso'] = Variable<int>(kmIngreso.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdenesCompanion(')
          ..write('id: $id, ')
          ..write('vehiculoId: $vehiculoId, ')
          ..write('mecanicoId: $mecanicoId, ')
          ..write('fechaEntrada: $fechaEntrada, ')
          ..write('problema: $problema, ')
          ..write('estado: $estado, ')
          ..write('kmIngreso: $kmIngreso')
          ..write(')'))
        .toString();
  }
}

class $TrabajosTable extends Trabajos with TableInfo<$TrabajosTable, Trabajo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrabajosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ordenIdMeta =
      const VerificationMeta('ordenId');
  @override
  late final GeneratedColumn<int> ordenId = GeneratedColumn<int>(
      'orden_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _precioMeta = const VerificationMeta('precio');
  @override
  late final GeneratedColumn<double> precio = GeneratedColumn<double>(
      'precio', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, ordenId, descripcion, precio];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trabajos';
  @override
  VerificationContext validateIntegrity(Insertable<Trabajo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('orden_id')) {
      context.handle(_ordenIdMeta,
          ordenId.isAcceptableOrUnknown(data['orden_id']!, _ordenIdMeta));
    } else if (isInserting) {
      context.missing(_ordenIdMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('precio')) {
      context.handle(_precioMeta,
          precio.isAcceptableOrUnknown(data['precio']!, _precioMeta));
    } else if (isInserting) {
      context.missing(_precioMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trabajo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trabajo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ordenId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}orden_id'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion'])!,
      precio: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}precio'])!,
    );
  }

  @override
  $TrabajosTable createAlias(String alias) {
    return $TrabajosTable(attachedDatabase, alias);
  }
}

class Trabajo extends DataClass implements Insertable<Trabajo> {
  final int id;
  final int ordenId;
  final String descripcion;
  final double precio;
  const Trabajo(
      {required this.id,
      required this.ordenId,
      required this.descripcion,
      required this.precio});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['orden_id'] = Variable<int>(ordenId);
    map['descripcion'] = Variable<String>(descripcion);
    map['precio'] = Variable<double>(precio);
    return map;
  }

  TrabajosCompanion toCompanion(bool nullToAbsent) {
    return TrabajosCompanion(
      id: Value(id),
      ordenId: Value(ordenId),
      descripcion: Value(descripcion),
      precio: Value(precio),
    );
  }

  factory Trabajo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trabajo(
      id: serializer.fromJson<int>(json['id']),
      ordenId: serializer.fromJson<int>(json['ordenId']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      precio: serializer.fromJson<double>(json['precio']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ordenId': serializer.toJson<int>(ordenId),
      'descripcion': serializer.toJson<String>(descripcion),
      'precio': serializer.toJson<double>(precio),
    };
  }

  Trabajo copyWith(
          {int? id, int? ordenId, String? descripcion, double? precio}) =>
      Trabajo(
        id: id ?? this.id,
        ordenId: ordenId ?? this.ordenId,
        descripcion: descripcion ?? this.descripcion,
        precio: precio ?? this.precio,
      );
  Trabajo copyWithCompanion(TrabajosCompanion data) {
    return Trabajo(
      id: data.id.present ? data.id.value : this.id,
      ordenId: data.ordenId.present ? data.ordenId.value : this.ordenId,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
      precio: data.precio.present ? data.precio.value : this.precio,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trabajo(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('descripcion: $descripcion, ')
          ..write('precio: $precio')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ordenId, descripcion, precio);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trabajo &&
          other.id == this.id &&
          other.ordenId == this.ordenId &&
          other.descripcion == this.descripcion &&
          other.precio == this.precio);
}

class TrabajosCompanion extends UpdateCompanion<Trabajo> {
  final Value<int> id;
  final Value<int> ordenId;
  final Value<String> descripcion;
  final Value<double> precio;
  const TrabajosCompanion({
    this.id = const Value.absent(),
    this.ordenId = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.precio = const Value.absent(),
  });
  TrabajosCompanion.insert({
    this.id = const Value.absent(),
    required int ordenId,
    required String descripcion,
    required double precio,
  })  : ordenId = Value(ordenId),
        descripcion = Value(descripcion),
        precio = Value(precio);
  static Insertable<Trabajo> custom({
    Expression<int>? id,
    Expression<int>? ordenId,
    Expression<String>? descripcion,
    Expression<double>? precio,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ordenId != null) 'orden_id': ordenId,
      if (descripcion != null) 'descripcion': descripcion,
      if (precio != null) 'precio': precio,
    });
  }

  TrabajosCompanion copyWith(
      {Value<int>? id,
      Value<int>? ordenId,
      Value<String>? descripcion,
      Value<double>? precio}) {
    return TrabajosCompanion(
      id: id ?? this.id,
      ordenId: ordenId ?? this.ordenId,
      descripcion: descripcion ?? this.descripcion,
      precio: precio ?? this.precio,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ordenId.present) {
      map['orden_id'] = Variable<int>(ordenId.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (precio.present) {
      map['precio'] = Variable<double>(precio.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrabajosCompanion(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('descripcion: $descripcion, ')
          ..write('precio: $precio')
          ..write(')'))
        .toString();
  }
}

class $RepuestosTable extends Repuestos
    with TableInfo<$RepuestosTable, Repuesto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepuestosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _precioMeta = const VerificationMeta('precio');
  @override
  late final GeneratedColumn<double> precio = GeneratedColumn<double>(
      'precio', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _existenciasMeta =
      const VerificationMeta('existencias');
  @override
  late final GeneratedColumn<int> existencias = GeneratedColumn<int>(
      'existencias', aliasedName, false,
      check: () => ComparableExpr(existencias).isBiggerOrEqualValue(0),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _stockMinimoMeta =
      const VerificationMeta('stockMinimo');
  @override
  late final GeneratedColumn<int> stockMinimo = GeneratedColumn<int>(
      'stock_minimo', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  @override
  List<GeneratedColumn> get $columns =>
      [id, nombre, codigo, precio, existencias, stockMinimo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repuestos';
  @override
  VerificationContext validateIntegrity(Insertable<Repuesto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (data.containsKey('precio')) {
      context.handle(_precioMeta,
          precio.isAcceptableOrUnknown(data['precio']!, _precioMeta));
    } else if (isInserting) {
      context.missing(_precioMeta);
    }
    if (data.containsKey('existencias')) {
      context.handle(
          _existenciasMeta,
          existencias.isAcceptableOrUnknown(
              data['existencias']!, _existenciasMeta));
    } else if (isInserting) {
      context.missing(_existenciasMeta);
    }
    if (data.containsKey('stock_minimo')) {
      context.handle(
          _stockMinimoMeta,
          stockMinimo.isAcceptableOrUnknown(
              data['stock_minimo']!, _stockMinimoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Repuesto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Repuesto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo'])!,
      precio: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}precio'])!,
      existencias: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}existencias'])!,
      stockMinimo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock_minimo'])!,
    );
  }

  @override
  $RepuestosTable createAlias(String alias) {
    return $RepuestosTable(attachedDatabase, alias);
  }
}

class Repuesto extends DataClass implements Insertable<Repuesto> {
  final int id;
  final String nombre;
  final String codigo;
  final double precio;
  final int existencias;
  final int stockMinimo;
  const Repuesto(
      {required this.id,
      required this.nombre,
      required this.codigo,
      required this.precio,
      required this.existencias,
      required this.stockMinimo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['codigo'] = Variable<String>(codigo);
    map['precio'] = Variable<double>(precio);
    map['existencias'] = Variable<int>(existencias);
    map['stock_minimo'] = Variable<int>(stockMinimo);
    return map;
  }

  RepuestosCompanion toCompanion(bool nullToAbsent) {
    return RepuestosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      codigo: Value(codigo),
      precio: Value(precio),
      existencias: Value(existencias),
      stockMinimo: Value(stockMinimo),
    );
  }

  factory Repuesto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Repuesto(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      codigo: serializer.fromJson<String>(json['codigo']),
      precio: serializer.fromJson<double>(json['precio']),
      existencias: serializer.fromJson<int>(json['existencias']),
      stockMinimo: serializer.fromJson<int>(json['stockMinimo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'codigo': serializer.toJson<String>(codigo),
      'precio': serializer.toJson<double>(precio),
      'existencias': serializer.toJson<int>(existencias),
      'stockMinimo': serializer.toJson<int>(stockMinimo),
    };
  }

  Repuesto copyWith(
          {int? id,
          String? nombre,
          String? codigo,
          double? precio,
          int? existencias,
          int? stockMinimo}) =>
      Repuesto(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        codigo: codigo ?? this.codigo,
        precio: precio ?? this.precio,
        existencias: existencias ?? this.existencias,
        stockMinimo: stockMinimo ?? this.stockMinimo,
      );
  Repuesto copyWithCompanion(RepuestosCompanion data) {
    return Repuesto(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      precio: data.precio.present ? data.precio.value : this.precio,
      existencias:
          data.existencias.present ? data.existencias.value : this.existencias,
      stockMinimo:
          data.stockMinimo.present ? data.stockMinimo.value : this.stockMinimo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Repuesto(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('codigo: $codigo, ')
          ..write('precio: $precio, ')
          ..write('existencias: $existencias, ')
          ..write('stockMinimo: $stockMinimo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, codigo, precio, existencias, stockMinimo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Repuesto &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.codigo == this.codigo &&
          other.precio == this.precio &&
          other.existencias == this.existencias &&
          other.stockMinimo == this.stockMinimo);
}

class RepuestosCompanion extends UpdateCompanion<Repuesto> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> codigo;
  final Value<double> precio;
  final Value<int> existencias;
  final Value<int> stockMinimo;
  const RepuestosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.codigo = const Value.absent(),
    this.precio = const Value.absent(),
    this.existencias = const Value.absent(),
    this.stockMinimo = const Value.absent(),
  });
  RepuestosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String codigo,
    required double precio,
    required int existencias,
    this.stockMinimo = const Value.absent(),
  })  : nombre = Value(nombre),
        codigo = Value(codigo),
        precio = Value(precio),
        existencias = Value(existencias);
  static Insertable<Repuesto> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? codigo,
    Expression<double>? precio,
    Expression<int>? existencias,
    Expression<int>? stockMinimo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (codigo != null) 'codigo': codigo,
      if (precio != null) 'precio': precio,
      if (existencias != null) 'existencias': existencias,
      if (stockMinimo != null) 'stock_minimo': stockMinimo,
    });
  }

  RepuestosCompanion copyWith(
      {Value<int>? id,
      Value<String>? nombre,
      Value<String>? codigo,
      Value<double>? precio,
      Value<int>? existencias,
      Value<int>? stockMinimo}) {
    return RepuestosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      codigo: codigo ?? this.codigo,
      precio: precio ?? this.precio,
      existencias: existencias ?? this.existencias,
      stockMinimo: stockMinimo ?? this.stockMinimo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (precio.present) {
      map['precio'] = Variable<double>(precio.value);
    }
    if (existencias.present) {
      map['existencias'] = Variable<int>(existencias.value);
    }
    if (stockMinimo.present) {
      map['stock_minimo'] = Variable<int>(stockMinimo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepuestosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('codigo: $codigo, ')
          ..write('precio: $precio, ')
          ..write('existencias: $existencias, ')
          ..write('stockMinimo: $stockMinimo')
          ..write(')'))
        .toString();
  }
}

class $OrdenRepuestosTable extends OrdenRepuestos
    with TableInfo<$OrdenRepuestosTable, OrdenRepuesto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdenRepuestosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ordenIdMeta =
      const VerificationMeta('ordenId');
  @override
  late final GeneratedColumn<int> ordenId = GeneratedColumn<int>(
      'orden_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _repuestoIdMeta =
      const VerificationMeta('repuestoId');
  @override
  late final GeneratedColumn<int> repuestoId = GeneratedColumn<int>(
      'repuesto_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cantidadMeta =
      const VerificationMeta('cantidad');
  @override
  late final GeneratedColumn<int> cantidad = GeneratedColumn<int>(
      'cantidad', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _precioUnitarioMeta =
      const VerificationMeta('precioUnitario');
  @override
  late final GeneratedColumn<double> precioUnitario = GeneratedColumn<double>(
      'precio_unitario', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ordenId, repuestoId, cantidad, precioUnitario];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orden_repuestos';
  @override
  VerificationContext validateIntegrity(Insertable<OrdenRepuesto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('orden_id')) {
      context.handle(_ordenIdMeta,
          ordenId.isAcceptableOrUnknown(data['orden_id']!, _ordenIdMeta));
    } else if (isInserting) {
      context.missing(_ordenIdMeta);
    }
    if (data.containsKey('repuesto_id')) {
      context.handle(
          _repuestoIdMeta,
          repuestoId.isAcceptableOrUnknown(
              data['repuesto_id']!, _repuestoIdMeta));
    } else if (isInserting) {
      context.missing(_repuestoIdMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(_cantidadMeta,
          cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta));
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('precio_unitario')) {
      context.handle(
          _precioUnitarioMeta,
          precioUnitario.isAcceptableOrUnknown(
              data['precio_unitario']!, _precioUnitarioMeta));
    } else if (isInserting) {
      context.missing(_precioUnitarioMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrdenRepuesto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrdenRepuesto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ordenId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}orden_id'])!,
      repuestoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}repuesto_id'])!,
      cantidad: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cantidad'])!,
      precioUnitario: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}precio_unitario'])!,
    );
  }

  @override
  $OrdenRepuestosTable createAlias(String alias) {
    return $OrdenRepuestosTable(attachedDatabase, alias);
  }
}

class OrdenRepuesto extends DataClass implements Insertable<OrdenRepuesto> {
  final int id;
  final int ordenId;
  final int repuestoId;
  final int cantidad;
  final double precioUnitario;
  const OrdenRepuesto(
      {required this.id,
      required this.ordenId,
      required this.repuestoId,
      required this.cantidad,
      required this.precioUnitario});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['orden_id'] = Variable<int>(ordenId);
    map['repuesto_id'] = Variable<int>(repuestoId);
    map['cantidad'] = Variable<int>(cantidad);
    map['precio_unitario'] = Variable<double>(precioUnitario);
    return map;
  }

  OrdenRepuestosCompanion toCompanion(bool nullToAbsent) {
    return OrdenRepuestosCompanion(
      id: Value(id),
      ordenId: Value(ordenId),
      repuestoId: Value(repuestoId),
      cantidad: Value(cantidad),
      precioUnitario: Value(precioUnitario),
    );
  }

  factory OrdenRepuesto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrdenRepuesto(
      id: serializer.fromJson<int>(json['id']),
      ordenId: serializer.fromJson<int>(json['ordenId']),
      repuestoId: serializer.fromJson<int>(json['repuestoId']),
      cantidad: serializer.fromJson<int>(json['cantidad']),
      precioUnitario: serializer.fromJson<double>(json['precioUnitario']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ordenId': serializer.toJson<int>(ordenId),
      'repuestoId': serializer.toJson<int>(repuestoId),
      'cantidad': serializer.toJson<int>(cantidad),
      'precioUnitario': serializer.toJson<double>(precioUnitario),
    };
  }

  OrdenRepuesto copyWith(
          {int? id,
          int? ordenId,
          int? repuestoId,
          int? cantidad,
          double? precioUnitario}) =>
      OrdenRepuesto(
        id: id ?? this.id,
        ordenId: ordenId ?? this.ordenId,
        repuestoId: repuestoId ?? this.repuestoId,
        cantidad: cantidad ?? this.cantidad,
        precioUnitario: precioUnitario ?? this.precioUnitario,
      );
  OrdenRepuesto copyWithCompanion(OrdenRepuestosCompanion data) {
    return OrdenRepuesto(
      id: data.id.present ? data.id.value : this.id,
      ordenId: data.ordenId.present ? data.ordenId.value : this.ordenId,
      repuestoId:
          data.repuestoId.present ? data.repuestoId.value : this.repuestoId,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      precioUnitario: data.precioUnitario.present
          ? data.precioUnitario.value
          : this.precioUnitario,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrdenRepuesto(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('repuestoId: $repuestoId, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioUnitario: $precioUnitario')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ordenId, repuestoId, cantidad, precioUnitario);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrdenRepuesto &&
          other.id == this.id &&
          other.ordenId == this.ordenId &&
          other.repuestoId == this.repuestoId &&
          other.cantidad == this.cantidad &&
          other.precioUnitario == this.precioUnitario);
}

class OrdenRepuestosCompanion extends UpdateCompanion<OrdenRepuesto> {
  final Value<int> id;
  final Value<int> ordenId;
  final Value<int> repuestoId;
  final Value<int> cantidad;
  final Value<double> precioUnitario;
  const OrdenRepuestosCompanion({
    this.id = const Value.absent(),
    this.ordenId = const Value.absent(),
    this.repuestoId = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.precioUnitario = const Value.absent(),
  });
  OrdenRepuestosCompanion.insert({
    this.id = const Value.absent(),
    required int ordenId,
    required int repuestoId,
    required int cantidad,
    required double precioUnitario,
  })  : ordenId = Value(ordenId),
        repuestoId = Value(repuestoId),
        cantidad = Value(cantidad),
        precioUnitario = Value(precioUnitario);
  static Insertable<OrdenRepuesto> custom({
    Expression<int>? id,
    Expression<int>? ordenId,
    Expression<int>? repuestoId,
    Expression<int>? cantidad,
    Expression<double>? precioUnitario,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ordenId != null) 'orden_id': ordenId,
      if (repuestoId != null) 'repuesto_id': repuestoId,
      if (cantidad != null) 'cantidad': cantidad,
      if (precioUnitario != null) 'precio_unitario': precioUnitario,
    });
  }

  OrdenRepuestosCompanion copyWith(
      {Value<int>? id,
      Value<int>? ordenId,
      Value<int>? repuestoId,
      Value<int>? cantidad,
      Value<double>? precioUnitario}) {
    return OrdenRepuestosCompanion(
      id: id ?? this.id,
      ordenId: ordenId ?? this.ordenId,
      repuestoId: repuestoId ?? this.repuestoId,
      cantidad: cantidad ?? this.cantidad,
      precioUnitario: precioUnitario ?? this.precioUnitario,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ordenId.present) {
      map['orden_id'] = Variable<int>(ordenId.value);
    }
    if (repuestoId.present) {
      map['repuesto_id'] = Variable<int>(repuestoId.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<int>(cantidad.value);
    }
    if (precioUnitario.present) {
      map['precio_unitario'] = Variable<double>(precioUnitario.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdenRepuestosCompanion(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('repuestoId: $repuestoId, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioUnitario: $precioUnitario')
          ..write(')'))
        .toString();
  }
}

class $PagosTable extends Pagos with TableInfo<$PagosTable, Pago> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PagosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ordenIdMeta =
      const VerificationMeta('ordenId');
  @override
  late final GeneratedColumn<int> ordenId = GeneratedColumn<int>(
      'orden_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<double> monto = GeneratedColumn<double>(
      'monto', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, ordenId, monto, fecha];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pagos';
  @override
  VerificationContext validateIntegrity(Insertable<Pago> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('orden_id')) {
      context.handle(_ordenIdMeta,
          ordenId.isAcceptableOrUnknown(data['orden_id']!, _ordenIdMeta));
    } else if (isInserting) {
      context.missing(_ordenIdMeta);
    }
    if (data.containsKey('monto')) {
      context.handle(
          _montoMeta, monto.isAcceptableOrUnknown(data['monto']!, _montoMeta));
    } else if (isInserting) {
      context.missing(_montoMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pago map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pago(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ordenId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}orden_id'])!,
      monto: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}monto'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
    );
  }

  @override
  $PagosTable createAlias(String alias) {
    return $PagosTable(attachedDatabase, alias);
  }
}

class Pago extends DataClass implements Insertable<Pago> {
  final int id;
  final int ordenId;
  final double monto;
  final DateTime fecha;
  const Pago(
      {required this.id,
      required this.ordenId,
      required this.monto,
      required this.fecha});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['orden_id'] = Variable<int>(ordenId);
    map['monto'] = Variable<double>(monto);
    map['fecha'] = Variable<DateTime>(fecha);
    return map;
  }

  PagosCompanion toCompanion(bool nullToAbsent) {
    return PagosCompanion(
      id: Value(id),
      ordenId: Value(ordenId),
      monto: Value(monto),
      fecha: Value(fecha),
    );
  }

  factory Pago.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pago(
      id: serializer.fromJson<int>(json['id']),
      ordenId: serializer.fromJson<int>(json['ordenId']),
      monto: serializer.fromJson<double>(json['monto']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ordenId': serializer.toJson<int>(ordenId),
      'monto': serializer.toJson<double>(monto),
      'fecha': serializer.toJson<DateTime>(fecha),
    };
  }

  Pago copyWith({int? id, int? ordenId, double? monto, DateTime? fecha}) =>
      Pago(
        id: id ?? this.id,
        ordenId: ordenId ?? this.ordenId,
        monto: monto ?? this.monto,
        fecha: fecha ?? this.fecha,
      );
  Pago copyWithCompanion(PagosCompanion data) {
    return Pago(
      id: data.id.present ? data.id.value : this.id,
      ordenId: data.ordenId.present ? data.ordenId.value : this.ordenId,
      monto: data.monto.present ? data.monto.value : this.monto,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pago(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ordenId, monto, fecha);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pago &&
          other.id == this.id &&
          other.ordenId == this.ordenId &&
          other.monto == this.monto &&
          other.fecha == this.fecha);
}

class PagosCompanion extends UpdateCompanion<Pago> {
  final Value<int> id;
  final Value<int> ordenId;
  final Value<double> monto;
  final Value<DateTime> fecha;
  const PagosCompanion({
    this.id = const Value.absent(),
    this.ordenId = const Value.absent(),
    this.monto = const Value.absent(),
    this.fecha = const Value.absent(),
  });
  PagosCompanion.insert({
    this.id = const Value.absent(),
    required int ordenId,
    required double monto,
    required DateTime fecha,
  })  : ordenId = Value(ordenId),
        monto = Value(monto),
        fecha = Value(fecha);
  static Insertable<Pago> custom({
    Expression<int>? id,
    Expression<int>? ordenId,
    Expression<double>? monto,
    Expression<DateTime>? fecha,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ordenId != null) 'orden_id': ordenId,
      if (monto != null) 'monto': monto,
      if (fecha != null) 'fecha': fecha,
    });
  }

  PagosCompanion copyWith(
      {Value<int>? id,
      Value<int>? ordenId,
      Value<double>? monto,
      Value<DateTime>? fecha}) {
    return PagosCompanion(
      id: id ?? this.id,
      ordenId: ordenId ?? this.ordenId,
      monto: monto ?? this.monto,
      fecha: fecha ?? this.fecha,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ordenId.present) {
      map['orden_id'] = Variable<int>(ordenId.value);
    }
    if (monto.present) {
      map['monto'] = Variable<double>(monto.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PagosCompanion(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientesTable clientes = $ClientesTable(this);
  late final $VehiculosTable vehiculos = $VehiculosTable(this);
  late final $MecanicosTable mecanicos = $MecanicosTable(this);
  late final $OrdenesTable ordenes = $OrdenesTable(this);
  late final $TrabajosTable trabajos = $TrabajosTable(this);
  late final $RepuestosTable repuestos = $RepuestosTable(this);
  late final $OrdenRepuestosTable ordenRepuestos = $OrdenRepuestosTable(this);
  late final $PagosTable pagos = $PagosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        clientes,
        vehiculos,
        mecanicos,
        ordenes,
        trabajos,
        repuestos,
        ordenRepuestos,
        pagos
      ];
}

typedef $$ClientesTableCreateCompanionBuilder = ClientesCompanion Function({
  Value<int> id,
  required String nombre,
  required String telefono,
  Value<String?> direccion,
});
typedef $$ClientesTableUpdateCompanionBuilder = ClientesCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<String> telefono,
  Value<String?> direccion,
});

class $$ClientesTableFilterComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefono => $composableBuilder(
      column: $table.telefono, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get direccion => $composableBuilder(
      column: $table.direccion, builder: (column) => ColumnFilters(column));
}

class $$ClientesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefono => $composableBuilder(
      column: $table.telefono, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get direccion => $composableBuilder(
      column: $table.direccion, builder: (column) => ColumnOrderings(column));
}

class $$ClientesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get direccion =>
      $composableBuilder(column: $table.direccion, builder: (column) => column);
}

class $$ClientesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClientesTable,
    Cliente,
    $$ClientesTableFilterComposer,
    $$ClientesTableOrderingComposer,
    $$ClientesTableAnnotationComposer,
    $$ClientesTableCreateCompanionBuilder,
    $$ClientesTableUpdateCompanionBuilder,
    (Cliente, BaseReferences<_$AppDatabase, $ClientesTable, Cliente>),
    Cliente,
    PrefetchHooks Function()> {
  $$ClientesTableTableManager(_$AppDatabase db, $ClientesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String> telefono = const Value.absent(),
            Value<String?> direccion = const Value.absent(),
          }) =>
              ClientesCompanion(
            id: id,
            nombre: nombre,
            telefono: telefono,
            direccion: direccion,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
            required String telefono,
            Value<String?> direccion = const Value.absent(),
          }) =>
              ClientesCompanion.insert(
            id: id,
            nombre: nombre,
            telefono: telefono,
            direccion: direccion,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ClientesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClientesTable,
    Cliente,
    $$ClientesTableFilterComposer,
    $$ClientesTableOrderingComposer,
    $$ClientesTableAnnotationComposer,
    $$ClientesTableCreateCompanionBuilder,
    $$ClientesTableUpdateCompanionBuilder,
    (Cliente, BaseReferences<_$AppDatabase, $ClientesTable, Cliente>),
    Cliente,
    PrefetchHooks Function()>;
typedef $$VehiculosTableCreateCompanionBuilder = VehiculosCompanion Function({
  Value<int> id,
  required int clienteId,
  required String matricula,
  required String marca,
  required String modelo,
  required int anio,
  required int km,
});
typedef $$VehiculosTableUpdateCompanionBuilder = VehiculosCompanion Function({
  Value<int> id,
  Value<int> clienteId,
  Value<String> matricula,
  Value<String> marca,
  Value<String> modelo,
  Value<int> anio,
  Value<int> km,
});

class $$VehiculosTableFilterComposer
    extends Composer<_$AppDatabase, $VehiculosTable> {
  $$VehiculosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get clienteId => $composableBuilder(
      column: $table.clienteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get matricula => $composableBuilder(
      column: $table.matricula, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get marca => $composableBuilder(
      column: $table.marca, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get modelo => $composableBuilder(
      column: $table.modelo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get anio => $composableBuilder(
      column: $table.anio, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get km => $composableBuilder(
      column: $table.km, builder: (column) => ColumnFilters(column));
}

class $$VehiculosTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiculosTable> {
  $$VehiculosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get clienteId => $composableBuilder(
      column: $table.clienteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get matricula => $composableBuilder(
      column: $table.matricula, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get marca => $composableBuilder(
      column: $table.marca, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get modelo => $composableBuilder(
      column: $table.modelo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get anio => $composableBuilder(
      column: $table.anio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get km => $composableBuilder(
      column: $table.km, builder: (column) => ColumnOrderings(column));
}

class $$VehiculosTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiculosTable> {
  $$VehiculosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get clienteId =>
      $composableBuilder(column: $table.clienteId, builder: (column) => column);

  GeneratedColumn<String> get matricula =>
      $composableBuilder(column: $table.matricula, builder: (column) => column);

  GeneratedColumn<String> get marca =>
      $composableBuilder(column: $table.marca, builder: (column) => column);

  GeneratedColumn<String> get modelo =>
      $composableBuilder(column: $table.modelo, builder: (column) => column);

  GeneratedColumn<int> get anio =>
      $composableBuilder(column: $table.anio, builder: (column) => column);

  GeneratedColumn<int> get km =>
      $composableBuilder(column: $table.km, builder: (column) => column);
}

class $$VehiculosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VehiculosTable,
    Vehiculo,
    $$VehiculosTableFilterComposer,
    $$VehiculosTableOrderingComposer,
    $$VehiculosTableAnnotationComposer,
    $$VehiculosTableCreateCompanionBuilder,
    $$VehiculosTableUpdateCompanionBuilder,
    (Vehiculo, BaseReferences<_$AppDatabase, $VehiculosTable, Vehiculo>),
    Vehiculo,
    PrefetchHooks Function()> {
  $$VehiculosTableTableManager(_$AppDatabase db, $VehiculosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiculosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiculosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiculosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> clienteId = const Value.absent(),
            Value<String> matricula = const Value.absent(),
            Value<String> marca = const Value.absent(),
            Value<String> modelo = const Value.absent(),
            Value<int> anio = const Value.absent(),
            Value<int> km = const Value.absent(),
          }) =>
              VehiculosCompanion(
            id: id,
            clienteId: clienteId,
            matricula: matricula,
            marca: marca,
            modelo: modelo,
            anio: anio,
            km: km,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int clienteId,
            required String matricula,
            required String marca,
            required String modelo,
            required int anio,
            required int km,
          }) =>
              VehiculosCompanion.insert(
            id: id,
            clienteId: clienteId,
            matricula: matricula,
            marca: marca,
            modelo: modelo,
            anio: anio,
            km: km,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$VehiculosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VehiculosTable,
    Vehiculo,
    $$VehiculosTableFilterComposer,
    $$VehiculosTableOrderingComposer,
    $$VehiculosTableAnnotationComposer,
    $$VehiculosTableCreateCompanionBuilder,
    $$VehiculosTableUpdateCompanionBuilder,
    (Vehiculo, BaseReferences<_$AppDatabase, $VehiculosTable, Vehiculo>),
    Vehiculo,
    PrefetchHooks Function()>;
typedef $$MecanicosTableCreateCompanionBuilder = MecanicosCompanion Function({
  Value<int> id,
  required String nombre,
});
typedef $$MecanicosTableUpdateCompanionBuilder = MecanicosCompanion Function({
  Value<int> id,
  Value<String> nombre,
});

class $$MecanicosTableFilterComposer
    extends Composer<_$AppDatabase, $MecanicosTable> {
  $$MecanicosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));
}

class $$MecanicosTableOrderingComposer
    extends Composer<_$AppDatabase, $MecanicosTable> {
  $$MecanicosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));
}

class $$MecanicosTableAnnotationComposer
    extends Composer<_$AppDatabase, $MecanicosTable> {
  $$MecanicosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);
}

class $$MecanicosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MecanicosTable,
    Mecanico,
    $$MecanicosTableFilterComposer,
    $$MecanicosTableOrderingComposer,
    $$MecanicosTableAnnotationComposer,
    $$MecanicosTableCreateCompanionBuilder,
    $$MecanicosTableUpdateCompanionBuilder,
    (Mecanico, BaseReferences<_$AppDatabase, $MecanicosTable, Mecanico>),
    Mecanico,
    PrefetchHooks Function()> {
  $$MecanicosTableTableManager(_$AppDatabase db, $MecanicosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MecanicosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MecanicosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MecanicosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
          }) =>
              MecanicosCompanion(
            id: id,
            nombre: nombre,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
          }) =>
              MecanicosCompanion.insert(
            id: id,
            nombre: nombre,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MecanicosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MecanicosTable,
    Mecanico,
    $$MecanicosTableFilterComposer,
    $$MecanicosTableOrderingComposer,
    $$MecanicosTableAnnotationComposer,
    $$MecanicosTableCreateCompanionBuilder,
    $$MecanicosTableUpdateCompanionBuilder,
    (Mecanico, BaseReferences<_$AppDatabase, $MecanicosTable, Mecanico>),
    Mecanico,
    PrefetchHooks Function()>;
typedef $$OrdenesTableCreateCompanionBuilder = OrdenesCompanion Function({
  Value<int> id,
  required int vehiculoId,
  required int mecanicoId,
  required DateTime fechaEntrada,
  required String problema,
  required Estado estado,
  required int kmIngreso,
});
typedef $$OrdenesTableUpdateCompanionBuilder = OrdenesCompanion Function({
  Value<int> id,
  Value<int> vehiculoId,
  Value<int> mecanicoId,
  Value<DateTime> fechaEntrada,
  Value<String> problema,
  Value<Estado> estado,
  Value<int> kmIngreso,
});

class $$OrdenesTableFilterComposer
    extends Composer<_$AppDatabase, $OrdenesTable> {
  $$OrdenesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get vehiculoId => $composableBuilder(
      column: $table.vehiculoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mecanicoId => $composableBuilder(
      column: $table.mecanicoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaEntrada => $composableBuilder(
      column: $table.fechaEntrada, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get problema => $composableBuilder(
      column: $table.problema, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Estado, Estado, String> get estado =>
      $composableBuilder(
          column: $table.estado,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get kmIngreso => $composableBuilder(
      column: $table.kmIngreso, builder: (column) => ColumnFilters(column));
}

class $$OrdenesTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdenesTable> {
  $$OrdenesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get vehiculoId => $composableBuilder(
      column: $table.vehiculoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mecanicoId => $composableBuilder(
      column: $table.mecanicoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaEntrada => $composableBuilder(
      column: $table.fechaEntrada,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get problema => $composableBuilder(
      column: $table.problema, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get kmIngreso => $composableBuilder(
      column: $table.kmIngreso, builder: (column) => ColumnOrderings(column));
}

class $$OrdenesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdenesTable> {
  $$OrdenesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get vehiculoId => $composableBuilder(
      column: $table.vehiculoId, builder: (column) => column);

  GeneratedColumn<int> get mecanicoId => $composableBuilder(
      column: $table.mecanicoId, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaEntrada => $composableBuilder(
      column: $table.fechaEntrada, builder: (column) => column);

  GeneratedColumn<String> get problema =>
      $composableBuilder(column: $table.problema, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Estado, String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<int> get kmIngreso =>
      $composableBuilder(column: $table.kmIngreso, builder: (column) => column);
}

class $$OrdenesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrdenesTable,
    Orden,
    $$OrdenesTableFilterComposer,
    $$OrdenesTableOrderingComposer,
    $$OrdenesTableAnnotationComposer,
    $$OrdenesTableCreateCompanionBuilder,
    $$OrdenesTableUpdateCompanionBuilder,
    (Orden, BaseReferences<_$AppDatabase, $OrdenesTable, Orden>),
    Orden,
    PrefetchHooks Function()> {
  $$OrdenesTableTableManager(_$AppDatabase db, $OrdenesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdenesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdenesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdenesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> vehiculoId = const Value.absent(),
            Value<int> mecanicoId = const Value.absent(),
            Value<DateTime> fechaEntrada = const Value.absent(),
            Value<String> problema = const Value.absent(),
            Value<Estado> estado = const Value.absent(),
            Value<int> kmIngreso = const Value.absent(),
          }) =>
              OrdenesCompanion(
            id: id,
            vehiculoId: vehiculoId,
            mecanicoId: mecanicoId,
            fechaEntrada: fechaEntrada,
            problema: problema,
            estado: estado,
            kmIngreso: kmIngreso,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int vehiculoId,
            required int mecanicoId,
            required DateTime fechaEntrada,
            required String problema,
            required Estado estado,
            required int kmIngreso,
          }) =>
              OrdenesCompanion.insert(
            id: id,
            vehiculoId: vehiculoId,
            mecanicoId: mecanicoId,
            fechaEntrada: fechaEntrada,
            problema: problema,
            estado: estado,
            kmIngreso: kmIngreso,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OrdenesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrdenesTable,
    Orden,
    $$OrdenesTableFilterComposer,
    $$OrdenesTableOrderingComposer,
    $$OrdenesTableAnnotationComposer,
    $$OrdenesTableCreateCompanionBuilder,
    $$OrdenesTableUpdateCompanionBuilder,
    (Orden, BaseReferences<_$AppDatabase, $OrdenesTable, Orden>),
    Orden,
    PrefetchHooks Function()>;
typedef $$TrabajosTableCreateCompanionBuilder = TrabajosCompanion Function({
  Value<int> id,
  required int ordenId,
  required String descripcion,
  required double precio,
});
typedef $$TrabajosTableUpdateCompanionBuilder = TrabajosCompanion Function({
  Value<int> id,
  Value<int> ordenId,
  Value<String> descripcion,
  Value<double> precio,
});

class $$TrabajosTableFilterComposer
    extends Composer<_$AppDatabase, $TrabajosTable> {
  $$TrabajosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordenId => $composableBuilder(
      column: $table.ordenId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precio => $composableBuilder(
      column: $table.precio, builder: (column) => ColumnFilters(column));
}

class $$TrabajosTableOrderingComposer
    extends Composer<_$AppDatabase, $TrabajosTable> {
  $$TrabajosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordenId => $composableBuilder(
      column: $table.ordenId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precio => $composableBuilder(
      column: $table.precio, builder: (column) => ColumnOrderings(column));
}

class $$TrabajosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrabajosTable> {
  $$TrabajosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ordenId =>
      $composableBuilder(column: $table.ordenId, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => column);

  GeneratedColumn<double> get precio =>
      $composableBuilder(column: $table.precio, builder: (column) => column);
}

class $$TrabajosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TrabajosTable,
    Trabajo,
    $$TrabajosTableFilterComposer,
    $$TrabajosTableOrderingComposer,
    $$TrabajosTableAnnotationComposer,
    $$TrabajosTableCreateCompanionBuilder,
    $$TrabajosTableUpdateCompanionBuilder,
    (Trabajo, BaseReferences<_$AppDatabase, $TrabajosTable, Trabajo>),
    Trabajo,
    PrefetchHooks Function()> {
  $$TrabajosTableTableManager(_$AppDatabase db, $TrabajosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrabajosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrabajosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrabajosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> ordenId = const Value.absent(),
            Value<String> descripcion = const Value.absent(),
            Value<double> precio = const Value.absent(),
          }) =>
              TrabajosCompanion(
            id: id,
            ordenId: ordenId,
            descripcion: descripcion,
            precio: precio,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int ordenId,
            required String descripcion,
            required double precio,
          }) =>
              TrabajosCompanion.insert(
            id: id,
            ordenId: ordenId,
            descripcion: descripcion,
            precio: precio,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TrabajosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TrabajosTable,
    Trabajo,
    $$TrabajosTableFilterComposer,
    $$TrabajosTableOrderingComposer,
    $$TrabajosTableAnnotationComposer,
    $$TrabajosTableCreateCompanionBuilder,
    $$TrabajosTableUpdateCompanionBuilder,
    (Trabajo, BaseReferences<_$AppDatabase, $TrabajosTable, Trabajo>),
    Trabajo,
    PrefetchHooks Function()>;
typedef $$RepuestosTableCreateCompanionBuilder = RepuestosCompanion Function({
  Value<int> id,
  required String nombre,
  required String codigo,
  required double precio,
  required int existencias,
  Value<int> stockMinimo,
});
typedef $$RepuestosTableUpdateCompanionBuilder = RepuestosCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<String> codigo,
  Value<double> precio,
  Value<int> existencias,
  Value<int> stockMinimo,
});

class $$RepuestosTableFilterComposer
    extends Composer<_$AppDatabase, $RepuestosTable> {
  $$RepuestosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precio => $composableBuilder(
      column: $table.precio, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get existencias => $composableBuilder(
      column: $table.existencias, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => ColumnFilters(column));
}

class $$RepuestosTableOrderingComposer
    extends Composer<_$AppDatabase, $RepuestosTable> {
  $$RepuestosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precio => $composableBuilder(
      column: $table.precio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get existencias => $composableBuilder(
      column: $table.existencias, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => ColumnOrderings(column));
}

class $$RepuestosTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepuestosTable> {
  $$RepuestosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<double> get precio =>
      $composableBuilder(column: $table.precio, builder: (column) => column);

  GeneratedColumn<int> get existencias => $composableBuilder(
      column: $table.existencias, builder: (column) => column);

  GeneratedColumn<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => column);
}

class $$RepuestosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RepuestosTable,
    Repuesto,
    $$RepuestosTableFilterComposer,
    $$RepuestosTableOrderingComposer,
    $$RepuestosTableAnnotationComposer,
    $$RepuestosTableCreateCompanionBuilder,
    $$RepuestosTableUpdateCompanionBuilder,
    (Repuesto, BaseReferences<_$AppDatabase, $RepuestosTable, Repuesto>),
    Repuesto,
    PrefetchHooks Function()> {
  $$RepuestosTableTableManager(_$AppDatabase db, $RepuestosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepuestosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepuestosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepuestosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String> codigo = const Value.absent(),
            Value<double> precio = const Value.absent(),
            Value<int> existencias = const Value.absent(),
            Value<int> stockMinimo = const Value.absent(),
          }) =>
              RepuestosCompanion(
            id: id,
            nombre: nombre,
            codigo: codigo,
            precio: precio,
            existencias: existencias,
            stockMinimo: stockMinimo,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
            required String codigo,
            required double precio,
            required int existencias,
            Value<int> stockMinimo = const Value.absent(),
          }) =>
              RepuestosCompanion.insert(
            id: id,
            nombre: nombre,
            codigo: codigo,
            precio: precio,
            existencias: existencias,
            stockMinimo: stockMinimo,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RepuestosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RepuestosTable,
    Repuesto,
    $$RepuestosTableFilterComposer,
    $$RepuestosTableOrderingComposer,
    $$RepuestosTableAnnotationComposer,
    $$RepuestosTableCreateCompanionBuilder,
    $$RepuestosTableUpdateCompanionBuilder,
    (Repuesto, BaseReferences<_$AppDatabase, $RepuestosTable, Repuesto>),
    Repuesto,
    PrefetchHooks Function()>;
typedef $$OrdenRepuestosTableCreateCompanionBuilder = OrdenRepuestosCompanion
    Function({
  Value<int> id,
  required int ordenId,
  required int repuestoId,
  required int cantidad,
  required double precioUnitario,
});
typedef $$OrdenRepuestosTableUpdateCompanionBuilder = OrdenRepuestosCompanion
    Function({
  Value<int> id,
  Value<int> ordenId,
  Value<int> repuestoId,
  Value<int> cantidad,
  Value<double> precioUnitario,
});

class $$OrdenRepuestosTableFilterComposer
    extends Composer<_$AppDatabase, $OrdenRepuestosTable> {
  $$OrdenRepuestosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordenId => $composableBuilder(
      column: $table.ordenId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get repuestoId => $composableBuilder(
      column: $table.repuestoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precioUnitario => $composableBuilder(
      column: $table.precioUnitario,
      builder: (column) => ColumnFilters(column));
}

class $$OrdenRepuestosTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdenRepuestosTable> {
  $$OrdenRepuestosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordenId => $composableBuilder(
      column: $table.ordenId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get repuestoId => $composableBuilder(
      column: $table.repuestoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precioUnitario => $composableBuilder(
      column: $table.precioUnitario,
      builder: (column) => ColumnOrderings(column));
}

class $$OrdenRepuestosTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdenRepuestosTable> {
  $$OrdenRepuestosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ordenId =>
      $composableBuilder(column: $table.ordenId, builder: (column) => column);

  GeneratedColumn<int> get repuestoId => $composableBuilder(
      column: $table.repuestoId, builder: (column) => column);

  GeneratedColumn<int> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<double> get precioUnitario => $composableBuilder(
      column: $table.precioUnitario, builder: (column) => column);
}

class $$OrdenRepuestosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrdenRepuestosTable,
    OrdenRepuesto,
    $$OrdenRepuestosTableFilterComposer,
    $$OrdenRepuestosTableOrderingComposer,
    $$OrdenRepuestosTableAnnotationComposer,
    $$OrdenRepuestosTableCreateCompanionBuilder,
    $$OrdenRepuestosTableUpdateCompanionBuilder,
    (
      OrdenRepuesto,
      BaseReferences<_$AppDatabase, $OrdenRepuestosTable, OrdenRepuesto>
    ),
    OrdenRepuesto,
    PrefetchHooks Function()> {
  $$OrdenRepuestosTableTableManager(
      _$AppDatabase db, $OrdenRepuestosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdenRepuestosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdenRepuestosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdenRepuestosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> ordenId = const Value.absent(),
            Value<int> repuestoId = const Value.absent(),
            Value<int> cantidad = const Value.absent(),
            Value<double> precioUnitario = const Value.absent(),
          }) =>
              OrdenRepuestosCompanion(
            id: id,
            ordenId: ordenId,
            repuestoId: repuestoId,
            cantidad: cantidad,
            precioUnitario: precioUnitario,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int ordenId,
            required int repuestoId,
            required int cantidad,
            required double precioUnitario,
          }) =>
              OrdenRepuestosCompanion.insert(
            id: id,
            ordenId: ordenId,
            repuestoId: repuestoId,
            cantidad: cantidad,
            precioUnitario: precioUnitario,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OrdenRepuestosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrdenRepuestosTable,
    OrdenRepuesto,
    $$OrdenRepuestosTableFilterComposer,
    $$OrdenRepuestosTableOrderingComposer,
    $$OrdenRepuestosTableAnnotationComposer,
    $$OrdenRepuestosTableCreateCompanionBuilder,
    $$OrdenRepuestosTableUpdateCompanionBuilder,
    (
      OrdenRepuesto,
      BaseReferences<_$AppDatabase, $OrdenRepuestosTable, OrdenRepuesto>
    ),
    OrdenRepuesto,
    PrefetchHooks Function()>;
typedef $$PagosTableCreateCompanionBuilder = PagosCompanion Function({
  Value<int> id,
  required int ordenId,
  required double monto,
  required DateTime fecha,
});
typedef $$PagosTableUpdateCompanionBuilder = PagosCompanion Function({
  Value<int> id,
  Value<int> ordenId,
  Value<double> monto,
  Value<DateTime> fecha,
});

class $$PagosTableFilterComposer extends Composer<_$AppDatabase, $PagosTable> {
  $$PagosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordenId => $composableBuilder(
      column: $table.ordenId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get monto => $composableBuilder(
      column: $table.monto, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));
}

class $$PagosTableOrderingComposer
    extends Composer<_$AppDatabase, $PagosTable> {
  $$PagosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordenId => $composableBuilder(
      column: $table.ordenId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get monto => $composableBuilder(
      column: $table.monto, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));
}

class $$PagosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PagosTable> {
  $$PagosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ordenId =>
      $composableBuilder(column: $table.ordenId, builder: (column) => column);

  GeneratedColumn<double> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);
}

class $$PagosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PagosTable,
    Pago,
    $$PagosTableFilterComposer,
    $$PagosTableOrderingComposer,
    $$PagosTableAnnotationComposer,
    $$PagosTableCreateCompanionBuilder,
    $$PagosTableUpdateCompanionBuilder,
    (Pago, BaseReferences<_$AppDatabase, $PagosTable, Pago>),
    Pago,
    PrefetchHooks Function()> {
  $$PagosTableTableManager(_$AppDatabase db, $PagosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PagosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PagosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PagosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> ordenId = const Value.absent(),
            Value<double> monto = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
          }) =>
              PagosCompanion(
            id: id,
            ordenId: ordenId,
            monto: monto,
            fecha: fecha,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int ordenId,
            required double monto,
            required DateTime fecha,
          }) =>
              PagosCompanion.insert(
            id: id,
            ordenId: ordenId,
            monto: monto,
            fecha: fecha,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PagosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PagosTable,
    Pago,
    $$PagosTableFilterComposer,
    $$PagosTableOrderingComposer,
    $$PagosTableAnnotationComposer,
    $$PagosTableCreateCompanionBuilder,
    $$PagosTableUpdateCompanionBuilder,
    (Pago, BaseReferences<_$AppDatabase, $PagosTable, Pago>),
    Pago,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientesTableTableManager get clientes =>
      $$ClientesTableTableManager(_db, _db.clientes);
  $$VehiculosTableTableManager get vehiculos =>
      $$VehiculosTableTableManager(_db, _db.vehiculos);
  $$MecanicosTableTableManager get mecanicos =>
      $$MecanicosTableTableManager(_db, _db.mecanicos);
  $$OrdenesTableTableManager get ordenes =>
      $$OrdenesTableTableManager(_db, _db.ordenes);
  $$TrabajosTableTableManager get trabajos =>
      $$TrabajosTableTableManager(_db, _db.trabajos);
  $$RepuestosTableTableManager get repuestos =>
      $$RepuestosTableTableManager(_db, _db.repuestos);
  $$OrdenRepuestosTableTableManager get ordenRepuestos =>
      $$OrdenRepuestosTableTableManager(_db, _db.ordenRepuestos);
  $$PagosTableTableManager get pagos =>
      $$PagosTableTableManager(_db, _db.pagos);
}
