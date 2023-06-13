import { useState } from 'react';
import formData from '../api/form.json';

export function DynamicForm() {

    const [formValues, setFormValues] = useState({});

    const handleChange = (e) => {
        setFormValues({ ...formValues, [e.target.name]: e.target.value });
      };

    return (
        <form>
      {formData.map((field) => (
        <div key={field.name}>
          <label>{field.label}</label>
          <input
            type={field.type}
            name={field.name}
            value={formValues[field.name] || ''}
            onChange={handleChange}
          />
        </div>
      ))}
      <button type="submit">Enviar</button>
    </form>
    )
}