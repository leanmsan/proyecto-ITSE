import React, { useState } from "react";
import { Link } from "react-router-dom";
import logo from "../img/logo1.png";
import "../css/menu.css";
import { useNavigate } from "react-router-dom";

export function Sidebar({ handleTabClick, selectedTab, handleAuthentication }) {
  const navigate = useNavigate();
  const [entradasOpen, setEntradasOpen] = useState(false);
  const [salidasOpen, setSalidasOpen] = useState(false);

  const handleLogout = () => {
    localStorage.removeItem("authenticated");
    handleAuthentication(false);
    navigate("/login");
  };

  const toggleEntradas = () => {
    setEntradasOpen(!entradasOpen);
    setSalidasOpen(false);
  };

  const toggleSalidas = () => {
    setSalidasOpen(!salidasOpen);
    setEntradasOpen(false);
  };

  const handleLogoClick = () => {
    navigate("/inicio");
  }

  return (
    <nav>
      <div className="logo-name">
        <div className="logo-image">
          <img src={logo} alt="Logo Cervecería Del Barco" onClick={handleLogoClick}/>
        </div>
      </div>

      <div className="menu-items">
        <div className="scrollable-sidebar">
        <ul className="nav-links">
          <li
            className={`nav-link-item ${
              selectedTab === "productos" ? "active" : ""
            }`}
          >
            <Link to="/productos">
              <i className="fa-solid fa-cart-flatbed nav-link-icon"></i>
              <span className="link-name">Productos</span>
            </Link>
          </li>
          <li
            className={`nav-link-item ${
              selectedTab === "altaProducto" ? "active" : ""
            }`}
          >
            <Link to="/altaproducto">
              <i className="fa-solid fa-square-plus nav-link-icon"></i>
              <span className="link-name">Alta de producto</span>
            </Link>
          </li>
          <li
            className={`nav-link-item ${
              selectedTab === "proveedores" ? "active" : ""
            }`}
          >
            <Link to="/proveedores">
              <i className="fa-solid fa-person-circle-plus nav-link-icon"></i>
              <span className="link-name">Proveedores</span>
            </Link>
          </li>

          <li
            className={`nav-link-item ${
              selectedTab === "proveedores" ? "active" : ""
            }`}
          >
            <Link to="/altaproveedores">
              <i className="fa-solid fa-person-circle-plus nav-link-icon"></i>
              <span className="link-name">Alta de Proveedores</span>
            </Link>
          </li>

          <li
            className={`nav-link-item ${
              selectedTab === "movimientos" ? "active" : ""
            }`}
          >
            <Link onClick={toggleEntradas}>
              <i className="fa-solid fa-person-circle-plus nav-link-icon"></i>
              <span className="link-name">Entradas</span>
            </Link>
          </li>

          <li
            className={`nav-link-item ${
              selectedTab === "movimientos" ? "active" : ""
            }`}
          >
            {entradasOpen && (
              <ul className="sub-menu">
                <li>
                  <Link to="/registroentradas">
                    <i className="fa-solid fa-cash-register nav-link-icon"></i>
                    <span className="link-name">Registro Entradas</span>
                  </Link>
                  <Link to="/entradas">
                    <i className="fa-solid fa-cash-register nav-link-icon"></i>
                    <span className="link-name">Tabla Entradas</span>
                  </Link>
                </li>
              </ul>
            )}
          </li>

          <li
            className={`nav-link-item ${
              selectedTab === "movimientos" ? "active" : ""
            }`}
          >
            <Link onClick={toggleSalidas}>
              <i className="fa-solid fa-person-circle-plus nav-link-icon"></i>
              <span className="link-name">Salidas</span>
            </Link>
          </li>

          <li
            className={`nav-link-item ${
              selectedTab === "movimientos" ? "active" : ""
            }`}
          >
            {salidasOpen && (
              <ul className="sub-menu">
                <li>
                  <Link to="/registrosalidas">
                    <i className="fa-solid fa-cash-register nav-link-icon"></i>
                    <span className="link-name">Registro Salidas</span>
                  </Link>
                  <Link to="/salidas">
                    <i className="fa-solid fa-cash-register nav-link-icon"></i>
                    <span className="link-name">Tabla Salidas</span>
                  </Link>
                </li>
              </ul>
            )}
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
        
      </div>
    </nav>
  );
}
