import { BrowserRouter, Route, Routes, Navigate } from 'react-router-dom'
import { useState } from 'react';
import { DynamicForm } from './components/DynamicForm';
import { Menu } from './pages/menu';
import { ProductosPage } from './pages/productosPage';
import { ProovedoresPage } from './pages/ProveedoresPage';
import { Login } from './components/login';
import { ProveedoresForm } from './components/altaProveedores';
import { TablaEntradasMovimientos } from './components/TablaEntradaMovimientos';
import { TablaSalidasMovimientos } from './components/TablaSalidaMovimiento';
import { RegistroEntradasForm } from './components/EntradasForm';
import { RegistroSalidasForm } from './components/SalidasForm';

function ProtectedRoute({ element: Component, authenticated, ...rest }) {
  return authenticated ? <Component {...rest} /> : <Navigate to="/" replace={true} />;
}
function App() {

  const [authenticated, setAuthenticated] = useState(
    localStorage.getItem('authenticated') === 'true' // Recuperar el estado de autenticación desde localStorage
  );

  const handleAuthentication = (status) => {
    setAuthenticated(status);
  };

  return (
    <div className='app'>
      <BrowserRouter basename="/">
        <Routes>
          <Route path='/' element={<Login handleAuthentication={handleAuthentication} />} />
          <Route
            path="/Menu"
            element={
              <ProtectedRoute
                element={Menu}
                authenticated={authenticated}
              />
            }
          />
          <Route
            path="/productos"
            element={
              <ProtectedRoute
                element={ProductosPage}
                authenticated={authenticated}
              />
            }
          />
          <Route
            path="/altaproducto"
            element={
              <ProtectedRoute
                element={DynamicForm}
                authenticated={authenticated}
              />
            }
          />
          <Route
            path="/proveedores"
            element={
              <ProtectedRoute
                element={ProovedoresPage}
                authenticated={authenticated}
              />
            }
          />
          <Route
            path="/altaproveedores"
            element={
              <ProtectedRoute
                element={ProveedoresForm}
                authenticated={authenticated}
              />
            }
          />

          <Route
            path="/salidas"
            element={
              <ProtectedRoute
                element={TablaSalidasMovimientos}
                authenticated={authenticated}
              />
            }

            
          />

          <Route
            path="/entradas"
            element={
              <ProtectedRoute
                element={TablaEntradasMovimientos}
                authenticated={authenticated}
              />
            }

            
          />

          <Route
            path="/registroentradas"
            element={
              <ProtectedRoute
                element={RegistroEntradasForm}
                authenticated={authenticated}
              />
            }
          />

          <Route
            path="/registrosalidas"
            element={
              <ProtectedRoute
                element={RegistroSalidasForm}
                authenticated={authenticated}
              />
            }
          />

        </Routes>
      </BrowserRouter>
    </div>

  )
}

export default App