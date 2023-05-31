from django.db import models

class Producto(models.Model):
    idproducto = models.AutoField(db_column='idProducto', primary_key=True)  # Field name made lowercase.
    nombre = models.CharField(max_length=100, blank=True, null=True)
    descripcion = models.CharField(max_length=200, blank=True, null=True)
    preciocompra = models.DecimalField(db_column='precioCompra', max_digits=10, decimal_places=2, blank=True, null=True)  # Field name made lowercase.
    precioventa = models.DecimalField(db_column='precioVenta', max_digits=10, decimal_places=2, blank=True, null=True)  # Field name made lowercase.
    marca = models.CharField(max_length=100, blank=True, null=True)
    stock = models.IntegerField(blank=True, null=True)
    rubro = models.CharField(max_length=11)

    class Meta:
        managed = False
        db_table = 'producto'

class Proveedor(models.Model):
    idproveedor = models.AutoField(db_column='idProveedor', primary_key=True)  # Field name made lowercase.
    cuitproveedor = models.CharField(db_column='CUITProveedor', max_length=15, blank=True, null=True)  # Field name made lowercase.
    nombre = models.CharField(max_length=120, blank=True, null=True)
    razonsocial = models.CharField(db_column='razonSocial', max_length=120, blank=True, null=True)  # Field name made lowercase.
    direccion = models.CharField(max_length=120, blank=True, null=True)
    localidad = models.CharField(max_length=120, blank=True, null=True)
    provincia = models.CharField(max_length=120, blank=True, null=True)
    contacto = models.CharField(max_length=80, blank=True, null=True)
    estadoproveedor = models.CharField(db_column='estadoProveedor', max_length=1)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'proveedor'

class Bateria(models.Model):
    idbateria = models.OneToOneField('Producto', models.DO_NOTHING, db_column='idBateria', primary_key=True)  # Field name made lowercase.
    amperaje = models.CharField(max_length=10, blank=True, null=True)
    voltaje = models.CharField(max_length=10, blank=True, null=True)
    tipo = models.CharField(max_length=60, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'bateria'

class DetalleMovimiento(models.Model):
    idmovimiento = models.OneToOneField('Movimiento', models.DO_NOTHING, db_column='idMovimiento', primary_key=True)  # Field name made lowercase. The composite primary key (idMovimiento, idProducto) found, that is not supported. The first column is selected.
    idproducto = models.ForeignKey('Producto', models.DO_NOTHING, db_column='idProducto')  # Field name made lowercase.
    tipo = models.CharField(max_length=10, blank=True, null=True)
    cantidadarticulo = models.IntegerField(db_column='cantidadArticulo', blank=True, null=True)  # Field name made lowercase.
    preciounitario = models.DecimalField(db_column='precioUnitario', max_digits=10, decimal_places=2, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'detalle_movimiento'
        unique_together = (('idmovimiento', 'idproducto'),)

class Filtro(models.Model):
    idfiltro = models.OneToOneField('Producto', models.DO_NOTHING, db_column='idFiltro', primary_key=True)  # Field name made lowercase.
    tipo = models.CharField(max_length=20, blank=True, null=True)
    vehiculo = models.CharField(max_length=150, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'filtro'

class Lampara(models.Model):
    idlampara = models.OneToOneField('Producto', models.DO_NOTHING, db_column='idLampara', primary_key=True)  # Field name made lowercase.
    voltaje = models.CharField(max_length=10, blank=True, null=True)
    watts = models.CharField(max_length=10, blank=True, null=True)
    tipo = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'lampara'

class Llanta(models.Model):
    idllanta = models.OneToOneField('Producto', models.DO_NOTHING, db_column='idLlanta', primary_key=True)  # Field name made lowercase.
    rodado = models.CharField(max_length=10, blank=True, null=True)
    ancho = models.CharField(max_length=10, blank=True, null=True)
    material = models.CharField(max_length=20, blank=True, null=True)
    estado = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'llanta'

class Lubricentro(models.Model):
    idlubricentro = models.OneToOneField('Producto', models.DO_NOTHING, db_column='idLubricentro', primary_key=True)  # Field name made lowercase.
    descripcionlubricentro = models.CharField(db_column='descripcionLubricentro', max_length=300, blank=True, null=True)  # Field name made lowercase.
    medida = models.CharField(max_length=10, blank=True, null=True)
    tipo = models.CharField(max_length=30, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'lubricentro'

class Movimiento(models.Model):
    idmovimiento = models.IntegerField(db_column='idMovimiento', primary_key=True)  # Field name made lowercase.
    idproveedor = models.ForeignKey('Proveedor', models.DO_NOTHING, db_column='idProveedor')  # Field name made lowercase.
    tipo = models.CharField(max_length=10, blank=True, null=True)
    fecha = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'movimiento'

class Neumatico(models.Model):
    idneumatico = models.OneToOneField('Producto', models.DO_NOTHING, db_column='idNeumatico', primary_key=True)  # Field name made lowercase.
    rodado = models.CharField(max_length=10, blank=True, null=True)
    ancho = models.CharField(max_length=10, blank=True, null=True)
    perfil = models.CharField(max_length=10, blank=True, null=True)
    indice = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'neumatico'
