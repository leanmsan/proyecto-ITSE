import { BrowserRouter, Route, Routes } from 'react-router-dom'
import {DynamicForm} from './components/DynamicForm';
import { Menu } from './pages/menu';
import { ProductoLista } from './pages/productoLista';
import { ProovedoresPage } from './pages/ProveedoresPage';

function App(){
  return (  
    <div className='app'>
      <BrowserRouter basename="/">
      <Menu />
      <Routes>
        <Route path='/productos' element={<ProductoLista />} />
        <Route path='/altaproducto' element={<DynamicForm />} />
        <Route path='/proveedores' element={<ProovedoresPage />} />
      </Routes>
      </BrowserRouter>
    </div>
     
  )
}

export default App