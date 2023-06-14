import { useState } from 'react';
import formData from '../api/form.json';
import "../css/form.css"
import { Menu } from '../pages/menu';

export function DynamicForm() {

    const [formValues, setFormValues] = useState({});

    const handleChange = (e) => {
        setFormValues({ ...formValues, [e.target.name]: e.target.value });
      };

    return (
      <div className='container'>
      <Menu className="menu"/>
        <form className='form'>
          <h1 className='title' >Alta de producto</h1>
      {formData.map((field) => (
        <div key={field.name}
        className='input-control'
        >
          <label>{field.label}</label>
          <input
            type={field.type}
            name={field.name}
            value={formValues[field.name] || ''}
            onChange={handleChange}
          />
        </div>
      ))}
      <button className='button' type="submit">Enviar</button>
    </form>
    </div>
    )
}