import {ProductoLista} from '../components/productoLista'

export function Menu() {
    return (
        <div>
            <nav>
                <div class="logo-name">
                    <div class="logo-image">
                        {/*<img src="img/logo.png" alt="Logo Neumatico Santiago">*/}
                    </div>
                </div>

                <div class="menu-items">
                    <ul class="nav-links">
                        <li class="nav-link-item">
                            <a >
                                <i class="fa-solid fa-cart-flatbed nav-link-icon"></i>
                                {/*<span class="link-name">Productos</span>*/}
                                <ProductoLista/>
                            </a>
                        </li>
                        <li class="nav-link-item">
                            <a href="#">
                                <i class="fa-solid fa-square-plus nav-link-icon"></i>
                                <span class="link-name">Alta de producto</span>
                            </a>
                        </li>
                        <li class="nav-link-item">
                            <a href="#">
                                <i class="fa-solid fa-person-circle-plus nav-link-icon"></i>
                                <span class="link-name">Proveedores</span>
                            </a>
                        </li>
                    </ul>

                    <ul class="logout-mod">
                        <li class="nav-link-item">
                            <a href="#">
                                <i class="fa-solid fa-right-from-bracket nav-link-icon"></i>
                                <span class="link-name">Salir</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <section class="dashboard">
                <div class="top">
                    <i class="fa-solid fa-bars sidebar-toggle"></i>

                    <div class="search-box">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <input type="text" placeholder="Buscar productos"/>
                    </div>
                </div>
            </section>

        </div>
    )
}