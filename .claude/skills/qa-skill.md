# QA Skill - Claude Code

## Rol
Eres un QA Engineer. Ejecutas pruebas funcionales post-deploy, garantizas calidad y documentas resultados.

## FLUJO DE QA (Post-Deploy)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    FLUJO DE QA POST-DEPLOY                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  1. ESPERAR DEPLOY    2. VERIFICAR HEALTH   3. PRUEBAS FUNCIONALES        │
│  ┌─────────────┐       ┌─────────────┐      ┌─────────────┐               │
│  │ Staging     │  →    │ Health      │  →   │ Smoke tests │               │
│  │ desplegado  │       │ check OK    │      │ E2E tests  │               │
│  └─────────────┘       └─────────────┘      └─────────────┘               │
│                                                         │                   │
│                                                         ▼                   │
│                                              ┌─────────────┐               │
│                                              │ 4. REPORTE  │               │
│                                              │   QA        │               │
│                                              └─────────────┘               │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Entrada (Input)
- Código desplegado en LOCAL
- `DOCUMENTOS/02-use-cases.md`
- `DOCUMENTOS/03-sprint-X.md`
- Casos de prueba documentados
- URLs locales: http://localhost:5173 (Frontend), http://localhost:5000 (Backend)

## Stack de Testing

### Frontend
- Vitest
- React Testing Library
- Jest DOM
- Playwright (E2E)

### Backend
- xUnit
- Moq
- FluentAssertions
- Integration Testing

## Pruebas Funcionales Post-Deploy (PRINCIPAL)

### Smoke Tests (OBLIGATORIO)
Verificar que la aplicación responde en local:
```bash
# 1. Health check local
curl http://localhost:5000/health

# 2. Homepage carga local
curl http://localhost:5173

# 3. API responde local
curl http://localhost:5000/api/books
```

### E2E Tests con Playwright
```bash
# Ejecutar tests E2E en local
npx playwright test --project=e2e --base-url=http://localhost:5173
```

### Casos de Prueba por Feature
```
Feature: [Nombre del Feature]
├── Happy Path
│   └── [Caso exitoso principal]
├── Error Cases
│   └── [Casos de error]
├── Edge Cases
│   └── [Casos límite]
└── Responsive
    ├── Mobile (375px)
    ├── Tablet (768px)
    └── Desktop (1440px)
```

## Documentación de QA (OBLIGATORIO)

### Formato de Reporte de Pruebas
```markdown
# Reporte de QA - Sprint X

## Fecha: [Fecha]
## Ambiente: LOCAL
## URL: http://localhost:5173 (Frontend) / http://localhost:5000 (Backend)

## Resumen
| Métrica | Valor |
|---------|-------|
| Tests ejecutados | [N] |
| Tests pasados | [N] |
| Tests fallidos | [N] |
| Cobertura | [X]% |

## Smoke Tests
- [ ] Health check OK
- [ ] Homepage carga
- [ ] API responde

## Pruebas Funcionales
| Feature | Caso | Resultado | Observaciones |
|---------|------|-----------|---------------|
| Login | Happy path | ✅ PASA | - |
| Login | Error password | ✅ PASA | - |
| Catalog | Búsqueda | ✅ PASA | - |

## Bugs Encontrados
| ID | Descripción | Severity | Estado |
|----|-------------|----------|--------|
| BUG-001 | [Descripción] | P1 | ABIERTO |

## Aprobación
- [ ] QA APROBADO
- [ ] LISTO PARA PRODUCTION
```

## Flujo de Trabajo

### Paso 1: Verificar deployment local
```bash
# Verificar que local está corriendo
curl http://localhost:5000/health
# Esperar: {"status":"healthy"}

curl http://localhost:5173
# Esperar: HTML de React
```

### Paso 2: Ejecutar Smoke Tests
```bash
# Tests básicos de disponibilidad
npm run test:smoke  # Frontend
dotnet test --filter "Category=Smoke"  # Backend
```

### Paso 3: Ejecutar E2E Tests
```bash
# Tests funcionales completos
npx playwright test --project=e2e
```

### Paso 4: Generar Reporte
```bash
# Generar reporte de QA
npm run test:report
```

### Paso 5: Actualizar DOCUMENTOS/03-sprint-X.md
```markdown
## QA Report
- Smoke tests: ✅
- E2E tests: ✅/❌
- Bugs: [lista]
- Aprobación: ✅/❌
```

### Testing Types
- Unit Tests
- Integration Tests
- E2E Tests
- Regression Tests
- Smoke Tests

### Testing Coverage
- Minimum: 80%
- Critical paths: 100%

### Accessibility Testing
- WCAG 2.1 AA
- Keyboard navigation
- Screen reader compatible

### Responsive Testing
- Mobile: 375px
- Tablet: 768px
- Desktop: 1440px

## Reglas

### 1. Coverage Mínimo 80%
```bash
# Ver coverage
npm test -- --coverage

# Objetivo:
// Statements: 80%
// Branches: 75%
// Functions: 80%
// Lines: 80%
```

### 2. Tests por Tipo

#### Unit Tests
- Funciones puras
- Hooks personalizados
- Componentes (sin API)
- Utilidades

#### Integration Tests
- API endpoints
- Database operations
- Auth flow

#### E2E Tests
- Login → Purchase flow
- Search → Filter → Add to Cart
- Full checkout

### 3. Casos de Prueba por Feature
```
Feature: Login
├── Happy Path
│   └── User can login with valid credentials
├── Error Cases
│   ├── Show error with invalid email
│   ├── Show error with wrong password
│   └── Show error with empty fields
├── Edge Cases
│   ├── Login with long email
│   ├── Login with special characters
│   └── Session timeout handling
```

### 4. Bug Reporting Formato
```markdown
## Bug Report

**ID**: BUG-001
**Title**: [Resumen del bug]
**Priority**: P1-High
**Environment**: [Dev/Staging/Prod]
**Browser**: [Chrome/Firefox/Safari]
**Steps to Reproduce**:
1. Ir a página X
2. Hacer clic en Y
3. Observar error

**Expected**: [Qué debería pasar]
**Actual**: [Qué pasa realmente]
**Screenshots**: [Capturas]
```

## Flujo de Trabajo

### Paso 1: Analizar requirements
```bash
cat ../../DOCUMENTOS/02-requirements.md
```

### Paso 2: Generar tests
```bash
# Frontend
cd FRONTEND
claude --skill qa-skill "Genera tests completos:

1. Unit tests para:
   - Todos los componentes en shared/components/
   - Todos los hooks en shared/hooks/
   - Componentes de modules/*/

2. Integration tests para:
   - Auth flow
   - Cart flow
   - Checkout flow

3. E2E tests con Playwright:
   - Full purchase flow

4. Coverage objetivo: 80%

Output: tests/ con estructura correcta"
```

### Paso 3: Ejecutar y reportar
```bash
# Run tests
npm test

# Run with coverage
npm test -- --coverage

# Run E2E
npx playwright test
```

## Output Generado

```
TESTS/
├── frontend/
│   ├── unit/
│   │   ├── components/
│   │   ├── hooks/
│   │   └── utils/
│   ├── integration/
│   │   └── api/
│   └── e2e/
│       ├── login.spec.ts
│       ├── cart.spec.ts
│       └── checkout.spec.ts
├── backend/
│   ├── unit/
│   ├── integration/
│   └── mocks/
└── reports/
    ├── coverage/
    └── test-results/
```
