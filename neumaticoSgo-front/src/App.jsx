import {BrowserRouter, Route, Routes, Navigate} from 'react-router-dom';
import { ProductosPage} from './pages/productosPage';
import { ProductoForm } from './pages/productoForm'
import {Navegacion} from './components/navegacion'
import {Menu} from './pages/menu'
function App(){
  return (  
    <div className='app'>
      <BrowserRouter>
          <Navegacion></Navegacion>
          <Routes>
              <Route path='/' element={<Menu/>}/>
              <Route path='/productos' element={<ProductosPage/>} />
              <Route path='/productoForm' element={<ProductoForm />} />
          </Routes>
      </BrowserRouter>
      
    </div>
      
  )
}

export default App