import '../css/menu.css'

export function NavBar() {
    return (
        <div>
            <div className="top">
                <i className="fa-solid fa-bars sidebar-toggle"></i>
                <div className="search-box">
                    <i className="fa-solid fa-magnifying-glass"></i>
                    <input type="text" placeholder="Buscar productos"/>
                </div>
            </div>
    </div>
    )
}