#!/bin/bash

# =============================================================================
# FRAMEWORK SETUP - Inicializa un nuevo proyecto con el framework
# =============================================================================
# Uso: ./setup.sh [NOMBRE_DEL_PROYECTO]
# Ejemplo: ./setup.sh mi-tienda-online
# =============================================================================

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Variables
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FRAMEWORK_DIR="$( cd "$( dirname "$SCRIPT_DIR" )" && pwd )"
PROJECT_NAME="${1:-nuevo-proyecto}"

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}  Framework Setup - Nuevo Proyecto${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""
echo -e "Proyecto: ${GREEN}$PROJECT_NAME${NC}"
echo ""

# -----------------------------------------------------------------------------
# Paso 1: Crear estructura de directorios
# -----------------------------------------------------------------------------
echo -e "${YELLOW}[1/6]${NC} Creando estructura de directorios..."

# Crear en el directorio padre (fuera del framework)
cd "$FRAMEWORK_DIR/.."
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Guardar el directorio base
BASE_DIR="$(pwd)"

mkdir -p FRONTEND/src/modules
mkdir -p FRONTEND/src/shared/components
mkdir -p BACKEND/src
mkdir -p DOCUMENTOS
mkdir -p .github/workflows

echo -e "  ✓ Estructura creada"

# -----------------------------------------------------------------------------
# Paso 2: Copiar configuración del framework
# -----------------------------------------------------------------------------
echo -e "${YELLOW}[2/6]${NC} Copiando configuración del framework..."

# Volver al directorio del proyecto
cd "$BASE_DIR"

# Copiar skills
mkdir -p .claude
cp -r "$FRAMEWORK_DIR/.claude/skills/" .claude/

# Copiar workflows
cp -r "$FRAMEWORK_DIR/.github/workflows/" .github/

echo -e "  ✓ Configuración copiada"

# -----------------------------------------------------------------------------
# Paso 3: Crear documentos base
# -----------------------------------------------------------------------------
echo -e "${YELLOW}[3/6]${NC} Creando documentos base..."

# Copiar plantillas
cp -r "$FRAMEWORK_DIR/DOCUMENTOS/plantillas/" DOCUMENTOS/

# Renombrar y personalizar
cd DOCUMENTOS

# Crear visión desde plantilla
sed "s/\[NOMBRE_DEL_PROYECTO\]/$PROJECT_NAME/g" plantillas/01-vision.md > 01-vision.md

# Crear backlog
sed "s/\[NOMBRE_DEL_PROYECTO\]/$PROJECT_NAME/g" plantillas/02-backlog.md > 02-backlog.md

# Crear contexto
sed "s/\[NOMBRE_DEL_PROYECTO\]/$PROJECT_NAME/g" plantillas/context.md > context.md

# Crear primer sprint
sed "s/\[NOMBRE_DEL_PROYECTO\]/$PROJECT_NAME/g" plantillas/03-sprint.md > 03-sprint-1.md

cd ..

echo -e "  ✓ Documentos creados"

# -----------------------------------------------------------------------------
# Paso 4: Inicializar Frontend
# -----------------------------------------------------------------------------
echo -e "${YELLOW}[4/6]${NC} Inicializando Frontend (React + Vite)..."

cd FRONTEND

# Crear package.json básico
cat > package.json << 'EOF'
{
  "name": "frontend",
  "private": true,
  "version": "0.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview",
    "test": "vitest"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.20.0",
    "zustand": "^4.4.0",
    "@tanstack/react-query": "^5.0.0",
    "lucide-react": "^0.294.0"
  },
  "devDependencies": {
    "@types/react": "^18.2.0",
    "@types/react-dom": "^18.2.0",
    "@vitejs/plugin-react": "^4.2.0",
    "autoprefixer": "^10.4.0",
    "postcss": "^8.4.0",
    "tailwindcss": "^3.3.0",
    "typescript": "^5.2.0",
    "vite": "^5.0.0",
    "vitest": "^1.0.0",
    "@testing-library/react": "^14.0.0",
    "jsdom": "^23.0.0"
  }
}
EOF

# Crear configuración básica
cat > vite.config.ts << 'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000
  }
})
EOF

cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
EOF

cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#f0f9ff',
          100: '#e0f2fe',
          500: '#0ea5e9',
          600: '#0284c7',
          700: '#0369a1',
          800: '#075985',
          900: '#0c4a6e',
        }
      }
    },
  },
  plugins: [],
}
EOF

cat > postcss.config.js << 'EOF'
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

# Crear archivos base
mkdir -p src
cat > src/main.tsx << 'EOF'
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.tsx'
import './index.css'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)
EOF

cat > src/App.tsx << 'EOF'
import { BrowserRouter, Routes, Route } from 'react-router-dom'

function App() {
  return (
    <BrowserRouter>
      <div className="min-h-screen bg-gray-50">
        <Routes>
          <Route path="/" element={<div className="p-8">Hola mundo!</div>} />
        </Routes>
      </div>
    </BrowserRouter>
  )
}

export default App
EOF

cat > src/index.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

cat > index.html << 'EOF'
<!doctype html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Nuevo Proyecto</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
EOF

cd ..

echo -e "  ✓ Frontend inicializado"

# -----------------------------------------------------------------------------
# Paso 5: Crear README del proyecto
# -----------------------------------------------------------------------------
echo -e "${YELLOW}[5/6]${NC} Creando README..."

cat > README.md << EOF
# $PROJECT_NAME

> E-commerce construido con el Framework de Desarrollo

## Quick Start

\`\`\`bash
# Instalar dependencias
cd FRONTEND && npm install

# Iniciar desarrollo
npm run dev
\`\`\`

## Documentación

Ver \`DOCUMENTOS/\` para más detalles.

## Sprints

- Sprint 1: \`DOCUMENTOS/03-sprint-1.md\`
- Sprint 2: \`DOCUMENTOS/03-sprint-2.md\`

---
*Generado con el Framework de Desarrollo*
EOF

echo -e "  ✓ README creado"

# -----------------------------------------------------------------------------
# Paso 6: Resumen
# -----------------------------------------------------------------------------
echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}  ¡Proyecto creado exitosamente!${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
echo -e "Próximos pasos:"
echo -e "  1. ${YELLOW}cd $PROJECT_NAME${NC}"
echo -e "  2. ${YELLOW}cd FRONTEND && npm install${NC}"
echo -e "  3. ${YELLOW}npm run dev${NC}"
echo ""
echo -e "Para iniciar desarrollo con IA:"
echo -e "  ${YELLOW}claude --skill analyst-skill${NC}"
echo ""
