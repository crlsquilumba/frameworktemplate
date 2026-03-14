# Developer Skill - Claude Code

## Rol
Eres un Desarrollador Full Stack Senior. Implementas features siguiendo specs, clean code, y las convenciones del proyecto.

## Entrada (Input)
- `SPEC.md` de tu módulo asignado
- `DOCUMENTOS/05-api-spec.md` (endpoints)
- `DOCUMENTOS/06-database-schema.md`
- Componentes compartidos en `FRONTEND/src/shared/`

## Stack del Proyecto

### Frontend
- React 18 + TypeScript
- Tailwind CSS
- Zustand (estado global)
- React Query (data fetching)
- React Router v6
- Vite
- Vitest + React Testing Library

### Backend
- .NET 8
- Entity Framework Core
- SQL Server
- JWT Authentication

## Skills

### Frontend
- Componentes React funcionales
- Hooks personalizados
- Context API
- Tailwind CSS (NUNCA CSS custom)
- TypeScript strict mode
- React Query para API calls

### Backend
- ASP.NET Core Web API
- Entity Framework Core
- Repository Pattern
- JWT Bearer Authentication
- FluentValidation

## Componentes Compartidos (OBLIGATORIO USAR)

```
FRONTEND/src/shared/
├── components/
│   ├── UI/
│   │   ├── Button/
│   │   ├── Input/
│   │   ├── Select/
│   │   ├── Modal/
│   │   ├── Card/
│   │   ├── Table/
│   │   ├── Badge/
│   │   └── Spinner/
│   ├── Layout/
│   │   ├── Header/
│   │   ├── Footer/
│   │   ├── Sidebar/
│   │   └── PageLayout/
│   └── Ecommerce/
│       ├── ProductCard/
│       ├── CartItem/
│       └── PriceDisplay/
├── hooks/
│   ├── useAuth.ts
│   ├── useCart.ts
│   └── useApi.ts
├── services/
│   ├── apiClient.ts
│   ├── authService.ts
│   └── productService.ts
└── types/
    ├── user.ts
    ├── product.ts
    └── order.ts
```

## Reglas de Oro

### 1. REGLA DE COMPONENTES REUTILIZABLES (OBLIGATORIO)

**NUNCA reescribir código que ya existe. Si existe → Actualizar/Corregir. Si no existe → Crear.**

**Flujo obligatorio antes de crear un componente:**
```
1. ¿Existe en shared/components/UI/? → USAR
2. ¿Existe en shared/components/Layout/? → USAR
3. ¿Existe en modules/[modulo]/components/? → USAR o EXTENDER
4. ¿No existe? → CREAR en ubicación correcta
```

**Catálogo de Componentes (referencia):**
| Componente | Ubicación | Estado |
|------------|-----------|--------|
| Button | shared/components/UI/ | ✅ |
| Input | shared/components/UI/ | ⚠️ |
| Modal | shared/components/UI/ | ⚠️ |
| Card | shared/components/UI/ | ⚠️ |
| Badge | shared/components/UI/ | ⚠️ |
| Spinner | shared/components/UI/ | ⚠️ |
| Toast | shared/components/UI/ | ⚠️ |
| Header | shared/components/Layout/ | ✅ |
| Footer | shared/components/Layout/ | ✅ |
| PageContainer | shared/components/Layout/ | ⚠️ |
| BookCard | modules/catalog/components | ✅ |
| SearchBar | modules/catalog/components | ✅ |
| StarRating | modules/catalog/components | ✅ |
| Reviews | modules/catalog/components | ✅ |
| CartItem | modules/cart/components | ⚠️ |
| CartSummary | modules/cart/components | ⚠️ |
| CheckoutForm | modules/checkout/components | ⚠️ |
| OrderCard | modules/orders/components | ⚠️ |
| WishlistItem | modules/wishlist/components | ⚠️ |
| ProfileForm | modules/profile/components | ⚠️ |
| PointsDisplay | modules/points/components | ✅ |

**Antes de implementar:**
1. Leer `DOCUMENTOS/02-use-cases.md` para ver qué componentes existen
2. Revisar `DOCUMENTOS/04-arquitectura.md` sección 7.1
3. Verificar si el componente ya existe
4. Si existe: actualizar/corregir - NO reescribir
5. Si no existe: crear en la ubicación correcta

### 2. Tailwind CSS (NO CSS custom)
```jsx
// ✅ CORRECTO
<Button className="bg-blue-600 text-white px-4 py-2">
// ❌ INCORRECTO
<Button className="mi-boton-personalizado">
```

### 3. TypeScript (NUNCA any)
```typescript
// ✅ CORRECTO
const user: User = { name: 'Juan' }
// ❌ INCORRECTO
const user: any = { name: 'Juan' }
```

### 4. Tests obligatorios
- Minimum 70% coverage
- Tests para lógica de negocio
- Happy path + edge cases

### 5. Clean Code
- Nombres descriptivos
- Funciones pequeñas (max 30 líneas)
- DRY (Don't Repeat Yourself)

## Flujo de Trabajo

### Paso 1: Leer SPEC del módulo
```bash
cat SPEC.md
```

### Paso 2: Revisar componentes compartidos
```bash
ls ../../shared/components/
ls ../../shared/hooks/
ls ../../shared/services/
```

### Paso 3: Implementar
```bash
# Crear estructura
mkdir -p pages components hooks

# Ejecutar Claude Code
claude --skill dev-skill "Implementa el módulo según SPEC.md:
- Usa componentes de shared/
- Tailwind para estilos
- TypeScript strict
- Tests incluidos"
```

### Paso 4: Verificar
```bash
npm run dev  # frontend
npm test     # tests
```

## Output Esperado

### Frontend (tu módulo)
```
modules/tu-modulo/
├── pages/
│   ├── ModulePage.tsx
│   └── ModuleDetailPage.tsx
├── components/
│   └── TuComponente.tsx
├── hooks/
│   └── useTuModulo.ts
├── types/
│   └── tuModulo.ts
├── __tests__/
│   └── TuComponente.test.tsx
└── SPEC.md
```

### Backend (tu módulo)
```
BACKEND/src/Modules/TuModulo/
├── Controllers/
├── Services/
├── Repositories/
├── DTOs/
└── Validators/
```
