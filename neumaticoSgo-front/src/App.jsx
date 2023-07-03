import { BrowserRouter, Route, Routes } from 'react-router-dom'
import {DynamicForm} from './components/DynamicForm';
import { Menu } from './pages/menu';
import { ProductosPage } from './pages/productosPage';
import { ProovedoresPage } from './pages/ProveedoresPage';
import {Login} from './components/login';


function App(){
  return (  
    <div className='app'>
      <BrowserRouter basename="/">
      <Routes>
        <Route path='' element={<Login />}  />
        <Route path='/Menu' element={<Menu/>} />
        <Route path='/productos' element={<ProductosPage/>} />
        <Route path='/altaproducto' element={<DynamicForm />} />
        <Route path='/proveedores' element={<ProovedoresPage />} />
      </Routes>
      </BrowserRouter>
    </div>
     
  )
}

export default App