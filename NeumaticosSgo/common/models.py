# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.

from django.db import models



class Entrada(models.Model):
    identrada = models.AutoField(db_column='idEntrada', primary_key=True)  # Field name made lowercase.
    idproveedor = models.ForeignKey('Proveedor', models.DO_NOTHING, db_column='idProveedor', blank=True, null=True)  # Field name made lowercase.
    fecha = models.DateTimeField(blank=True, null=True)
    montototal = models.DecimalField(db_column='montoTotal', max_digits=10, decimal_places=2, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'entrada'


class Entradadetalle(models.Model):
    identrada = models.IntegerField(db_column='idEntrada', primary_key=True)  # Field name made lowercase. The composite primary key (idEntrada, idInsumo) found, that is not supported. The first column is selected.
    idinsumo = models.ForeignKey('Insumo', models.DO_NOTHING, db_column='idInsumo')  # Field name made lowercase.
    cantidad = models.IntegerField()
    preciounitario = models.DecimalField(db_column='precioUnitario', max_digits=10, decimal_places=2, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'entradadetalle'
        unique_together = (('identrada', 'idinsumo'),)


class Insumo(models.Model):
    idinsumo = models.IntegerField(db_column='idInsumo', primary_key=True)
    descripcion = models.CharField(max_length=80, unique=True, null=True)
    cantidad_disponible = models.IntegerField(blank=True, null=True)
    tipo_medida = models.CharField(max_length=5, blank=True, null=True)
    categoria = models.CharField(max_length=20, blank=True, null=True)
    precio_unitario = models.FloatField(blank=True, null=True)
    proveedor = models.ForeignKey('Proveedor', models.DO_NOTHING, db_column='proveedor', to_field='nombre', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'insumo'
        unique_together = (('idinsumo', 'descripcion'),)


class Proveedor(models.Model):
    idproveedor = models.IntegerField(db_column='idProveedor', primary_key=True)  # Field name made lowercase.
    nombre = models.CharField(db_column='nombre', unique=True, max_length=20, blank=True, null=True)
    mail = models.CharField(max_length=80, blank=True, null=True)
    telefono = models.CharField(max_length=20, blank=True, null=True)
    estado = models.CharField(max_length=1, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'proveedor'


class Recetadetalle(models.Model):
    idreceta = models.IntegerField(db_column='idReceta', primary_key=True)  # Field name made lowercase. The composite primary key (idReceta, idInsumo) found, that is not supported. The first column is selected.
    idinsumo = models.ForeignKey(Insumo, models.DO_NOTHING, db_column='idInsumo')  # Field name made lowercase.
    cantidad = models.IntegerField()
    tipo_medida = models.CharField(max_length=5, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'recetadetalle'
        unique_together = (('idreceta', 'idinsumo'),)


class Recetas(models.Model):
    idreceta = models.IntegerField(db_column='idReceta', primary_key=True)  # Field name made lowercase.
    nombre = models.CharField(max_length=50)
    tipo = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'recetas'


class Salida(models.Model):
    idsalida = models.AutoField(db_column='idSalida', primary_key=True)  # Field name made lowercase.
    fecha = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'salida'


class Salidadetalle(models.Model):
    idsalida = models.IntegerField(db_column='idSalida', primary_key=True)  # Field name made lowercase. The composite primary key (idSalida, idInsumo) found, that is not supported. The first column is selected.
    idinsumo = models.ForeignKey(Insumo, models.DO_NOTHING, db_column='idInsumo')  # Field name made lowercase.
    cantidad = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'salidadetalle'
        unique_together = (('idsalida', 'idinsumo'),)
