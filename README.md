# Framework de Desarrollo - E-Commerce

> Sistema de desarrollo por sprints integrado con Claude Code

---

## ¿Qué es este framework?

Un **sistema de desarrollo ágil asistido por IA** que permite crear proyectos completos siguiendo una metodología Scrum, donde Claude Code funciona como "desarrollador virtual" ejecutando las tareas de cada sprint.

---

## Flujo de Trabajo (Nuevo)

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         CONSULTOR (Fase Inicial)                        │
│  ┌─────────────────────────────────────────────────────────────────┐  │
│  │ 1. Entiende necesidades del usuario                             │  │
│  │ 2. Crea PROTOTYPE.html (prototipo funcional)                    │  │
│  │ 3. Genera documentación (product design, use cases)             │  │
│  │ 4. Planifica sprints                                           │  │
│  └─────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────┘
                                    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                           ARQUITECTO                                    │
│  ┌─────────────────────────────────────────────────────────────────┐  │
│  │ • API Spec                                                    │  │
│  │ • Database Schema                                             │  │
│  │ • Arquitectura técnica                                        │  │
│  └─────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────┘
                                    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                     DESARROLLADOR (Por Sprint)                          │
│  ┌─────────────────────────────────────────────────────────────────┐  │
│  │ Sprint 1 → Sprint 2 → Sprint 3 → ...                          │  │
│  └─────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────┘
                                    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                              QA                                        │
│  ┌─────────────────────────────────────────────────────────────────┐  │
│  │ • Tests unitarios                                             │  │
│  │ • Tests de integración                                        │  │
│  │ • Coverage > 80%                                              │  │
│  └─────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────┘
                                    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                             DEVOPS                                      │
│  ┌─────────────────────────────────────────────────────────────────┐  │
│  │ • CI/CD                                                       │  │
│  │ • Deploy                                                     │  │
│  │ • Monitoreo                                                   │  │
│  └─────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Estructura

```
.framework-template/
├── .claude/skills/              # 6 roles de IA
│   ├── consultant-skill.md     # Consultor/Product Manager (NUEVO)
│   ├── analyst-skill.md       # Analista de requisitos
│   ├── architect-skill.md      # Arquitecto de soluciones
│   ├── dev-skill.md          # Desarrollador Full Stack
│   ├── qa-skill.md           # Ingeniero de QA
│   └── devops-skill.md       # DevOps Engineer
├── .github/workflows/          # CI/CD
├── DOCUMENTOS/                  # Plantillas
└── scripts/
    └── setup.sh               # Inicializador
```

---

## Quick Start - Nuevo Flujo

### Paso 1: Consulta con el Consultor

```bash
# Inicia conversando con el consultor
claude --skill consultant

# Ejemplo de conversación:
# "Quiero hacer una plataforma de cursos online"
```

El consultor te hará preguntas como:
- ¿Qué tipo de aplicación necesitas?
- ¿Quiénes son los usuarios?
- ¿Qué funcionalidades principales requiere?
- ¿Hay referencias o competidores?
- ¿Qué estilo visual prefieres?

### Paso 2: Prototipo Automático

El consultor crea `PROTOTYPE.html` con:
- ✅ Diseño responsive (mobile/tablet/desktop)
- ✅ Todas las funcionalidades pedidas
- ✅ Interactividad completa (botones, formularios, modales)
- ✅ Estilo profesional moderno

### Paso 3: Documentación

El consultor genera automáticamente:
- `DOCUMENTOS/01-product-design.md` - Diseño de producto
- `DOCUMENTOS/02-use-cases.md` - Casos de uso completos
- `DOCUMENTOS/03-technical-analysis.md` - Análisis técnico
- `DOCUMENTOS/04-sprint-plan.md` - Plan de sprints

### Paso 4: Desarrollo por Sprints

Una vez tienes el prototipo y documentación:

```bash
# Sprint 1
claude --skill dev-skill "Implementa Sprint 1 según PROTOTYPE.html y DOCUMENTOS/"

# Sprint 2
claude --skill dev-skill "Implementa Sprint 2..."

# Y así sucesivamente...
```

---

## Skills Disponibles

| Skill | Comando | Función |
|-------|---------|---------|
| **Consultor** | `claude --skill consultant` | Entiende necesidades, crea prototipo HTML, genera docs |
| **Analista** | `claude --skill analyst-skill` | Analiza requisitos |
| **Arquitecto** | `claude --skill architect-skill` | Diseña arquitectura técnica |
| **Desarrollador** | `claude --skill dev-skill` | Implementa código |
| **QA** | `claude --skill qa-skill` | Crea tests |
| **DevOps** | `claude --skill devops-skill` | Configura deployment |

---

## Ejemplo Completo

```
> Usuario: Quiero hacer una app de delivery

> Consultant Skill:
¡Genial! Necesito saber más:
1. ¿Delivery de qué? (comida, productos, medicamentos)
2. ¿Usuarios pueden ser repartidores también?
3. ¿Métodos de pago?
4. ¿Zona de cobertura?
5. ¿Estilo visual?

> Usuario: Delivery de comida, usuarios repartidores, 
           pagos con tarjeta, zona centro ciudad, 
           estilo moderno rojo/negro

> Consultant Skill:
[CREA PROTOTYPE.html con]
- Login/Registro (usuario + repartidor)
- Homepage con restaurantes
- Carrito de compras
- Tracking de pedido
- Panel repartidor
- Checkout con tarjeta
- Historial de pedidos
- Perfil de usuario

[CREA DOCUMENTACIÓN]
- 01-product-design.md
- 02-use-cases.md
- 03-technical-analysis.md  
- 04-sprint-plan.md

> Usuario: Agrega reseñas de restaurantes

> Consultant Skill:
[ACTUALIZA PROTOTYPE.html con sistema de reseñas]
[ACTUALIZA DOCUMENTACIÓN]

> Ahora sí, a desarrollar:
> claude --skill architect-skill "Diseña según PROTOTYPE.html"
> claude --skill dev-skill "Implementa Sprint 1"
```

---

## Comandos Útiles

```bash
# Iniciar nuevo proyecto (hablar con consultor)
claude --skill consultant

# Agregar funcionalidad al prototipo
claude --skill consultant "Agrega [feature]"

# Generar documentación
claude --skill consultant "Genera docs completas"

# Arquitectura
claude --skill architect-skill

# Desarrollo
claude --skill dev-skill

# Testing
claude --skill qa-skill

# Deploy
claude --skill devops-skill
```

---

## Plantillas de Documentación

El framework incluye plantillas en `DOCUMENTOS/plantillas/`:

- `01-product-design.md` - Diseño de producto
- `02-use-cases.md` - Casos de uso
- `03-technical-analysis.md` - Análisis técnico
- `04-sprint-plan.md` - Plan de sprints
- `context.md` - Contexto técnico
- `vision.md` - Visión del producto

---

## Requisitos

- Node.js 18+
- .NET 8 SDK (opcional, según proyecto)
- Git
- Claude Code

---

*Framework creado con Claude Code*
