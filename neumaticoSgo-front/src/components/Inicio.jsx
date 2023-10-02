import { Sidebar } from './Sidebar';
import { NavBar } from './NavBar';
import Slider from 'react-slick';
import 'slick-carousel/slick/slick';
import 'slick-carousel/slick/slick.css';
import 'slick-carousel/slick/slick-theme.css'
import '../css/inicio.css'

// importacion de imagenes para el slider
import img1 from '../img/img-1.png';
import img2 from '../img/img-2.png';
import img3 from '../img/img-3.png';
import img4 from '../img/img-4.png';
import img5 from '../img/img-5.png';
import img6 from '../img/img-6.png';

export const Inicio = () => {
  const settings = {
    dots: true,
    infinite: true,
    speed: 500,
    slidesToShow: 2,
    slidesToScroll: 1,
    autoplay: true,
    autoplaySpeed: 2000,
  };

  return (
    <div>
      <NavBar />
      <Sidebar />
      <div className="home">
        <div className='home-title'>
          <h1 className='title'>Sistema de Gestión de Producción</h1>
        </div>
        <div className='slider-container'>
        <div className="photo-slider">
          <Slider {...settings}>
            <div>
              <img src={img1} alt="Imagen 1"/>
            </div>
            <div>
              <img src={img2} alt="Imagen 2"/>
            </div>
            <div>
              <img src={img3} alt="Imagen 3"/>
            </div>
            <div>
              <img src={img4} alt="Imagen 4"/>
            </div>
            <div>
              <img src={img5} alt="Imagen 5"/>
            </div>
            <div>
              <img src={img6} alt="Imagen 6"/>
            </div>
          </Slider>
        </div>
        </div>
      </div>
    </div>
  );
};
