# 🔍 Verificación de Credenciales Supabase

Esta guía te ayudará a verificar que tus credenciales de Supabase estén correctamente configuradas.

## ⚠️ Problema Detectado

El archivo `env.local` tenía un formato incorrecto:
- ❌ Usaba `:` en lugar de `=`
- ❌ Tenía espacios y punto y coma innecesarios
- ❌ El nombre debería ser `.env.local` (con punto al inicio)

## ✅ Solución Aplicada

Se creó el archivo `.env.local` con el formato correcto usando el script `create-env.ps1`.

## 🔑 Verificar Credenciales

### 1. Obtener Credenciales Correctas desde Supabase

1. Ve a tu proyecto en [Supabase Dashboard](https://supabase.com/dashboard)
2. Navega a **Settings** → **API**
3. Copia los siguientes valores:

   - **Project URL** → `NEXT_PUBLIC_SUPABASE_URL`
   - **anon public** key → `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - **service_role** key → `SUPABASE_SERVICE_ROLE_KEY`

### 2. Formato Esperado

Las credenciales de Supabase tienen este formato:

**URL:**
```
https://xxxxx.supabase.co
```

**Anon Key (pública):**
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh4eHh4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODk4NzY1NDAsImV4cCI6MjAwNTQ1MjU0MH0.xxxxx
```

**Service Role Key (privada):**
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh4eHh4Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4OTg3NjU0MCwiZXhwIjoyMDA1NDUyNTQwfQ.xxxxx
```

### 3. Verificar Archivo .env.local

Abre `.env.local` y verifica que tenga este formato:

```env
NEXT_PUBLIC_SUPABASE_URL=https://tu-proyecto.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**IMPORTANTE:**
- ✅ Sin espacios alrededor del `=`
- ✅ Sin punto y coma al final
- ✅ Sin comillas (a menos que el valor las contenga)
- ✅ Una variable por línea

## 🧪 Probar Conexión

### Opción 1: Desde el Navegador

1. Ejecuta `pnpm run dev`
2. Abre `http://localhost:3000`
3. Abre la consola del navegador (F12)
4. Busca errores relacionados con Supabase

### Opción 2: Script de Prueba

Crea un archivo `test-supabase.js`:

```javascript
const { createClient } = require('@supabase/supabase-js');
require('dotenv').config({ path: '.env.local' });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

console.log('URL:', supabaseUrl);
console.log('Key:', supabaseKey ? '✅ Presente' : '❌ Faltante');

const supabase = createClient(supabaseUrl, supabaseKey);

// Probar conexión
supabase.from('services').select('count').then(({ data, error }) => {
  if (error) {
    console.error('❌ Error:', error.message);
  } else {
    console.log('✅ Conexión exitosa');
  }
});
```

## 🐛 Errores Comunes

### Error: "Invalid API key"
- **Causa:** La key no es válida o está mal copiada
- **Solución:** Copia nuevamente desde Supabase Dashboard

### Error: "Failed to fetch"
- **Causa:** URL incorrecta o proyecto pausado
- **Solución:** Verifica la URL y que el proyecto esté activo

### Error: "Cannot read property 'from'"
- **Causa:** Variables de entorno no cargadas
- **Solución:** Reinicia el servidor de desarrollo (`pnpm run dev`)

### Error: "Row Level Security policy violation"
- **Causa:** Las políticas RLS están bloqueando el acceso
- **Solución:** Verifica que ejecutaste el script SQL de `docs/SETUP_DATABASE.md`

## 📝 Notas Importantes

1. **Nunca commitees `.env.local`** - Está en `.gitignore`
2. **Las keys públicas (`NEXT_PUBLIC_*`) se exponen al cliente** - Está bien, están diseñadas para eso
3. **La `service_role` key es privada** - Solo úsala en el servidor, nunca en el cliente
4. **Reinicia el servidor** después de cambiar `.env.local`

---

**¿Sigue fallando?** Verifica que:
- ✅ El archivo se llama `.env.local` (con punto)
- ✅ Está en la raíz del proyecto
- ✅ Las credenciales son correctas
- ✅ El proyecto de Supabase está activo



