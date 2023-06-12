import React from "react";
import MaterialTable from 'material-table';
import { ThemeProvider, createTheme } from "@mui/material";
import { forwardRef } from "react";
import AddBox from '@material-ui/icons/AddBox';
import ArrowDownward from '@material-ui/icons/ArrowDownward';
import Check from '@material-ui/icons/Check';
import ChevronLeft from '@material-ui/icons/ChevronLeft';
import ChevronRight from '@material-ui/icons/ChevronRight';
import Clear from '@material-ui/icons/Clear';
import Delete from '@material-ui/icons/Delete';
import Edit from '@material-ui/icons/Edit';
import FilterList from '@material-ui/icons/FilterList';
import FirstPage from '@material-ui/icons/FirstPage';
import LastPage from '@material-ui/icons/LastPage';
import Remove from '@material-ui/icons/Remove';
import SaveAlt from '@material-ui/icons/SaveAlt';
import Search from '@material-ui/icons/Search';
import ViewColumn from '@material-ui/icons/ViewColumn';

export function TablaProducto() {
  const columnas=[
    {
      title:'Descripción',
      field: 'descripcion',
    },
    {
      title: 'Marca',
      field: 'marca',
    },
    {
      title: 'Modelo',
      field: 'modelo',
    },
    {
      title: 'Stock',
      field: 'stock',
      type: "numeric"
    }
  ]

  

  const data = [
    {descripcion: 'Llanta R14 ', marca: 'Original', modelo: 'R14', stock: 10},
    {descripcion: 'Llanta R15', marca: 'Original', modelo: 'R15', stock: 20},
    {descripcion: 'Cubierta 225/45 R17', marca: 'Goodyear', modelo: 'EfficientGrip', stock: 6},
    {descripcion: 'Cubierta 185/65 R14', marca: 'Firestone', modelo: 'Firehawk', stock: 15},
    {descripcion: 'Aceite Liqui Moly 5W30', marca: 'Liqui Moly', modelo: 'Molygen', stock: 8},
    {descripcion: 'Cubierta 225/45 R17', marca: 'Michelin', modelo: 'Primacy 3', stock: 10},
    {descripcion: 'Aceite Total Ineo 5W30', marca: 'Total', modelo: 'Ineo', stock: 12},
    {descripcion: 'Bateria Moura 12V90A', marca: 'Moura', modelo: 'M24KD', stock: 2},
  ];
  const defaultMaterialTheme = createTheme();
  const tableIcons = {
    Add: forwardRef((props, ref) => <AddBox {...props} ref={ref} />),
    Check: forwardRef((props, ref) => <Check {...props} ref={ref} />),
    Clear: forwardRef((props, ref) => <Clear {...props} ref={ref} />),
    Delete: forwardRef((props, ref) => <Delete {...props} ref={ref} />),
    DetailPanel: forwardRef((props, ref) => <ChevronRight {...props} ref={ref} />),
    Edit: forwardRef((props, ref) => <Edit {...props} ref={ref} />),
    Export: forwardRef((props, ref) => <SaveAlt {...props} ref={ref} />),
    Filter: forwardRef((props, ref) => <FilterList {...props} ref={ref} />),
    FirstPage: forwardRef((props, ref) => <FirstPage {...props} ref={ref} />),
    LastPage: forwardRef((props, ref) => <LastPage {...props} ref={ref} />),
    NextPage: forwardRef((props, ref) => <ChevronRight {...props} ref={ref} />),
    PreviousPage: forwardRef((props, ref) => <ChevronLeft {...props} ref={ref} />),
    ResetSearch: forwardRef((props, ref) => <Clear {...props} ref={ref} />),
    Search: forwardRef((props, ref) => <Search {...props} ref={ref} />),
    SortArrow: forwardRef((props, ref) => <ArrowDownward {...props} ref={ref} />),
    ThirdStateCheck: forwardRef((props, ref) => <Remove {...props} ref={ref} />),
    ViewColumn: forwardRef((props, ref) => <ViewColumn {...props} ref={ref} />)
    };

  return (
    <div>
      <ThemeProvider theme={defaultMaterialTheme}>
      <MaterialTable
        icons={tableIcons}
        columns={columnas}
        data={data}
        title = "Productos"
        actions ={[
          {
            icon: Edit,
            tooltip: 'Editar',
            onClick: (event, rowData) => alert('Estas por editar el artículo '+rowData.descripcion)
          },
          {
            icon: Delete,
            tooltip: 'Eliminar',
            onClick: (event, rowData) => alert('Estas por eliminar el artículo '+rowData.descripcion)
          }
        ]}
        options={{
          actionsColumnIndex: -1
        }}
        localization={{
          header:{
            actions: 'Acciones',
          }
        }}
        />
        </ThemeProvider>
    </div>
  );
}

export default App;
