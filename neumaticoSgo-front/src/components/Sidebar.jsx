import { Link } from 'react-router-dom'
import logo from '../img/logo.png'
import '../css/menu.css'
import { useNavigate } from 'react-router-dom';

export function Sidebar({ handleTabClick, selectedTab, handleAuthentication }) {

    const navigate = useNavigate();

    const handleLogout = () => {
        localStorage.removeItem('authenticated');
        handleAuthentication(false);
        navigate('/login');
    };

    return (
        <nav>
            <div className="logo-name">
                <div className="logo-image">
                    <img src={logo} alt="Logo Neumatico Santiago" />
                </div>
            </div>

            <div className="menu-items">
                <ul className="nav-links">
                    <li className={`nav-link-item ${selectedTab === 'inicio' ? 'active' : ''}`}>
                        <Link to="/inicio" >
                            <i className="fa-solid fa-house-chimney nav-link-icon"></i>
                            <span className="link-name">Inicio</span>
                        </Link>
                    </li>
                    <li className={`nav-link-item ${selectedTab === 'productos' ? 'active' : ''}`}>
                        <Link to="/productos" >
                            <i className="fa-solid fa-cart-flatbed nav-link-icon"></i>
                            <span className="link-name">Productos</span>
                        </Link>
                    </li>
                    <li className={`nav-link-item ${selectedTab === 'altaProducto' ? 'active' : ''}`}>
                        <Link to="/altaproducto" >
                            <i className="fa-solid fa-square-plus nav-link-icon"></i>
                            <span className="link-name">Alta de producto</span>
                        </Link>
                    </li>
                    <li className={`nav-link-item ${selectedTab === 'proveedores' ? 'active' : ''}`}>
                        <Link to="/proveedores" >
                            <i className="fa-solid fa-person-circle-plus nav-link-icon"></i>
                            <span className="link-name">Proveedores</span>
                        </Link>
                    </li>

                    <li className={`nav-link-item ${selectedTab === 'proveedores' ? 'active' : ''}`}>
                        <Link to="/altaproveedores" >
                            <i className="fa-solid fa-person-circle-plus nav-link-icon"></i>
                            <span className="link-name">Alta de Proveedores</span>
                        </Link>
                    </li>
                    <li className={`nav-link-item ${selectedTab === 'movimientos' ? 'active' : ''}`}>
                        <Link to="/entradas"
                        >
                            <i className="fa-solid fa-cash-register nav-link-icon"></i>
                            <span className="link-name">Entradas</span>
                        </Link>
                    </li>
                    <li className={`nav-link-item ${selectedTab === 'movimientos' ? 'active' : ''}`}>
                        <Link to="/registroentradas"
                        >
                            <i className="fa-solid fa-cash-register nav-link-icon"></i>
                            <span className="link-name">Registro Entradas</span>
                        </Link>
                    </li>
                    <li className={`nav-link-item ${selectedTab === 'movimientos' ? 'active' : ''}`}>
                        <Link to="/salidas"
                        >
                            <i className="fa-solid fa-cash-register nav-link-icon"></i>
                            <span className="link-name">Salidas</span>
                        </Link>
                    </li>
                    <li className={`nav-link-item ${selectedTab === 'movimientos' ? 'active' : ''}`}>
                        <Link to="/registrosalidas"
                        >
                            <i className="fa-solid fa-cash-register nav-link-icon"></i>
                            <span className="link-name">Registro Salidas</span>
                        </Link>
                    </li>
                </ul>

                <ul className="logout-mod">
                    <li className="nav-link-item">
                        <Link onClick={handleLogout}>
                            <i className="fa-solid fa-right-from-bracket nav-link-icon"></i>
                            <span className="link-name">Salir</span>
                        </Link>
                    </li>
                </ul>

            </div>
        </nav>
    )
}