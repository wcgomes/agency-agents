# AGENT_ROUTING.md

## Purpose

This guide helps route work to the right division and then to the right agent.

Always classify the work by division first.
Only choose a specific agent after ownership is clear.

---

## Routing Model

Every request should be classified as:

- **Primary Division** — owns the outcome
- **Secondary Division** — provides essential supporting expertise
- **Supporting Division(s)** — optional contributors when useful

### Rule
If the task is naturally cross-functional, model it explicitly.
Do not force a single-division choice when ownership and execution are split.

---

## Quick Routing Heuristics

| Work Type | Primary Division | Common Secondary Divisions |
| --- | --- | --- |
| New feature / product capability | Product Division | Design Division, Engineering Division, Testing Division |
| UI implementation / frontend work | Engineering Division | Design Division, Testing Division |
| Backend / API / architecture / infrastructure | Engineering Division | Product Division, Testing Division |
| Roadmap / PRD / prioritization / discovery | Product Division | Design Division, Engineering Division |
| UX redesign / design system / research | Design Division | Product Division, Engineering Division |
| Task breakdown / execution plan / coordination | Project Management Division | Product Division, Engineering Division |
| QA / release readiness / evidence / accessibility | Testing Division | Engineering Division, Design Division |
| Launch campaign / growth / SEO / content | Marketing Division | Design Division, Product Division, Sales Division |
| PPC / paid social / tracking / ad performance | Paid Media Division | Marketing Division, Support Division |
| Pipeline / proposals / discovery calls / pre-sales | Sales Division | Product Division, Engineering Division |
| Reporting / compliance / support ops / executive visibility | Support Division | Project Management Division, Engineering Division |
| XR / AR / VR / visionOS / spatial interfaces | Spatial Computing Division | Design Division, Engineering Division |
| Game systems / engines / gameplay / worldbuilding for games | Game Development Division | Design Division, Engineering Division, Academic Division |
| Cultural / historical / psychological / geographic rigor for narratives or worlds | Academic Division | Design Division, Product Division, Game Development Division |
| Cross-functional workflow / orchestration / niche domain | Specialized Division | depends on scenario |
| Production incident / reliability issue | Engineering Division or SRE | Testing Division, Support Division, Project Management Division |

---

## Selection Heuristic

When routing is ambiguous:

1. Define the final business outcome
2. Choose the division accountable for that outcome
3. Add the division(s) required to execute successfully
4. Only then choose the specific agent(s)

### Important
Do not route by keywords alone.
Route by:
- ownership
- final deliverable
- required expertise
- execution dependencies

---

## Engineering Division

Building the future, one commit at a time.

| Agent | Specialty | When to Use |
| --- | --- | --- |
| Frontend Developer | React/Vue/Angular, UI implementation, performance | Modern web apps, pixel-perfect UIs, Core Web Vitals optimization |
| Backend Architect | API design, database architecture, scalability | Server-side systems, microservices, cloud infrastructure |
| Mobile App Builder | iOS/Android, React Native, Flutter | Native and cross-platform mobile applications |
| AI Engineer | ML models, deployment, AI integration | Machine learning features, data pipelines, AI-powered apps |
| DevOps Automator | CI/CD, infrastructure automation, cloud ops | Pipeline development, deployment automation, monitoring |
| Rapid Prototyper | Fast POC development, MVPs | Quick proof-of-concepts, hackathon projects, fast iteration |
| Senior Developer | Laravel/Livewire, advanced patterns | Complex implementations, architecture decisions |
| Security Engineer | Threat modeling, secure code review, security architecture | Application security, vulnerability assessment, security CI/CD |
| Autonomous Optimization Architect | LLM routing, cost optimization, shadow testing | Autonomous systems needing intelligent API selection and cost guardrails |
| Embedded Firmware Engineer | Bare-metal, RTOS, ESP32/STM32/Nordic firmware | Production-grade embedded systems and IoT devices |
| Incident Response Commander | Incident management, post-mortems, on-call | Managing production incidents and building incident readiness |
| Solidity Smart Contract Engineer | EVM contracts, gas optimization, DeFi | Secure, gas-optimized smart contracts and DeFi protocols |
| Technical Writer | Developer docs, API reference, tutorials | Clear, accurate technical documentation |
| Threat Detection Engineer | SIEM rules, threat hunting, ATT&CK mapping | Building detection layers and threat hunting |
| WeChat Mini Program Developer | WeChat ecosystem, Mini Programs, payment integration | Building performant apps for the WeChat ecosystem |
| Code Reviewer | Constructive code review, security, maintainability | PR reviews, code quality gates, mentoring through review |
| Database Optimizer | Schema design, query optimization, indexing strategies | PostgreSQL/MySQL tuning, slow query debugging, migration planning |
| Git Workflow Master | Branching strategies, conventional commits, advanced Git | Git workflow design, history cleanup, CI-friendly branch management |
| Software Architect | System design, DDD, architectural patterns, trade-off analysis | Architecture decisions, domain modeling, system evolution strategy |
| SRE | SLOs, error budgets, observability, chaos engineering | Production reliability, toil reduction, capacity planning |
| AI Data Remediation Engineer | Self-healing pipelines, air-gapped SLMs, semantic clustering | Fixing broken data at scale with zero data loss |
| Data Engineer | Data pipelines, lakehouse architecture, ETL/ELT | Building reliable data infrastructure and warehousing |
| Feishu Integration Developer | Feishu/Lark Open Platform, bots, workflows | Building integrations for the Feishu ecosystem |

---

## Design Division

Making it beautiful, usable, and delightful.

| Agent | Specialty | When to Use |
| --- | --- | --- |
| UI Designer | Visual design, component libraries, design systems | Interface creation, brand consistency, component design |
| UX Researcher | User testing, behavior analysis, research | Understanding users, usability testing, design insights |
| UX Architect | Technical architecture, CSS systems, implementation | Developer-friendly foundations, implementation guidance |
| Brand Guardian | Brand identity, consistency, positioning | Brand strategy, identity development, guidelines |
| Visual Storyteller | Visual narratives, multimedia content | Compelling visual stories, brand storytelling |
| Whimsy Injector | Personality, delight, playful interactions | Adding joy, micro-interactions, Easter eggs, brand personality |
| Image Prompt Engineer | AI image generation prompts, photography | Photography prompts for Midjourney, DALL-E, Stable Diffusion |
| Inclusive Visuals Specialist | Representation, bias mitigation, authentic imagery | Generating culturally accurate AI images and video |

---

## Paid Media Division

Turning ad spend into measurable business outcomes.

| Agent | Specialty | When to Use |
| --- | --- | --- |
| PPC Campaign Strategist | Google/Microsoft/Amazon Ads, account architecture, bidding | Account buildouts, budget allocation, scaling, performance diagnosis |
| Search Query Analyst | Search term analysis, negative keywords, intent mapping | Query audits, wasted spend elimination, keyword discovery |
| Paid Media Auditor | 200+ point account audits, competitive analysis | Account takeovers, quarterly reviews, competitive pitches |
| Tracking & Measurement Specialist | GTM, GA4, conversion tracking, CAPI | New implementations, tracking audits, platform migrations |
| Ad Creative Strategist | RSA copy, Meta creative, Performance Max assets | Creative launches, testing programs, ad fatigue refreshes |
| Programmatic & Display Buyer | GDN, DSPs, partner media, ABM display | Display planning, partner outreach, ABM programs |
| Paid Social Strategist | Meta, LinkedIn, TikTok, cross-platform social | Social ad programs, platform selection, audience strategy |

---

## Sales Division

Turning pipeline into revenue through craft, not CRM busywork.

| Agent | Specialty | When to Use |
| --- | --- | --- |
| Outbound Strategist | Signal-based prospecting, multi-channel sequences, ICP targeting | Building pipeline through research-driven outreach, not volume |
| Discovery Coach | SPIN, Gap Selling, Sandler — question design and call structure | Preparing for discovery calls, qualifying opportunities, coaching reps |
| Deal Strategist | MEDDPICC qualification, competitive positioning, win planning | Scoring deals, exposing pipeline risk, building win strategies |
| Sales Engineer | Technical demos, POC scoping, competitive battlecards | Pre-sales technical wins, demo prep, competitive positioning |
| Proposal Strategist | RFP response, win themes, narrative structure | Writing proposals that persuade, not just comply |
| Pipeline Analyst | Forecasting, pipeline health, deal velocity, RevOps | Pipeline reviews, forecast accuracy, revenue operations |
| Account Strategist | Land-and-expand, QBRs, stakeholder mapping | Post-sale expansion, account planning, NRR growth |
| Sales Coach | Rep development, call coaching, pipeline review facilitation | Making every rep and every deal better through structured coaching |

---

## Marketing Division

Growing your audience, one authentic interaction at a time.

| Agent | Specialty | When to Use |
| --- | --- | --- |
| Growth Hacker | Rapid user acquisition, viral loops, experiments | Explosive growth, user acquisition, conversion optimization |
| Content Creator | Multi-platform content, editorial calendars | Content strategy, copywriting, brand storytelling |
| Twitter Engager | Real-time engagement, thought leadership | Twitter strategy, LinkedIn campaigns, professional social |
| TikTok Strategist | Viral content, algorithm optimization | TikTok growth, viral content, Gen Z/Millennial audience |
| Instagram Curator | Visual storytelling, community building | Instagram strategy, aesthetic development, visual content |
| Reddit Community Builder | Authentic engagement, value-driven content | Reddit strategy, community trust, authentic marketing |
| App Store Optimizer | ASO, conversion optimization, discoverability | App marketing, store optimization, app growth |
| Social Media Strategist | Cross-platform strategy, campaigns | Overall social strategy, multi-platform campaigns |
| Xiaohongshu Specialist | Lifestyle content, trend-driven strategy | Xiaohongshu growth, aesthetic storytelling, Gen Z audience |
| WeChat Official Account Manager | Subscriber engagement, content marketing | WeChat OA strategy, community building, conversion optimization |
| Zhihu Strategist | Thought leadership, knowledge-driven engagement | Zhihu authority building, Q&A strategy, lead generation |
| Baidu SEO Specialist | Baidu optimization, China SEO, ICP compliance | Ranking in Baidu and reaching China's search market |
| Bilibili Content Strategist | B站 algorithm, danmaku culture, UP主 growth | Building audiences on Bilibili with community-first content |
| Carousel Growth Engine | TikTok/Instagram carousels, autonomous publishing | Generating and publishing viral carousel content |
| LinkedIn Content Creator | Personal branding, thought leadership, professional content | LinkedIn growth, professional audience building, B2B content |
| China E-Commerce Operator | Taobao, Tmall, Pinduoduo, live commerce | Running multi-platform e-commerce in China |
| Kuaishou Strategist | Kuaishou, 老铁 community, grassroots growth | Building authentic audiences in lower-tier markets |
| SEO Specialist | Technical SEO, content strategy, link building | Driving sustainable organic search growth |
| Book Co-Author | Thought-leadership books, ghostwriting, publishing | Strategic book collaboration for founders and experts |
| Cross-Border E-Commerce Specialist | Amazon, Shopee, Lazada, cross-border fulfillment | Full-funnel cross-border e-commerce strategy |
| Douyin Strategist | Douyin platform, short-video marketing, algorithm | Growing audiences on China's leading short-video platform |
| Livestream Commerce Coach | Host training, live room optimization, conversion | Building high-performing livestream e-commerce operations |
| Podcast Strategist | Podcast content strategy, platform optimization | Chinese podcast market strategy and operations |
| Private Domain Operator | WeCom, private traffic, community operations | Building enterprise WeChat private domain ecosystems |
| Short-Video Editing Coach | Post-production, editing workflows, platform specs | Hands-on short-video editing training and optimization |
| Weibo Strategist | Sina Weibo, trending topics, fan engagement | Full-spectrum Weibo operations and growth |
| AI Citation Strategist | AEO/GEO, AI recommendation visibility, citation auditing | Improving brand visibility across ChatGPT, Claude, Gemini, Perplexity |

---

## Product Division

Building the right thing at the right time.

| Agent | Specialty | When to Use |
| --- | --- | --- |
| Sprint Prioritizer | Agile planning, feature prioritization | Sprint planning, resource allocation, backlog management |
| Trend Researcher | Market intelligence, competitive analysis | Market research, opportunity assessment, trend identification |
| Feedback Synthesizer | User feedback analysis, insights extraction | Feedback analysis, user insights, product priorities |
| Behavioral Nudge Engine | Behavioral psychology, nudge design, engagement | Maximizing user motivation through behavioral science |
| Product Manager | Full lifecycle product ownership | Discovery, PRDs, roadmap planning, GTM, outcome measurement |

---

## Project Management Division

Keeping the trains running on time (and under budget).

| Agent | Specialty | When to Use |
| --- | --- | --- |
| Studio Producer | High-level orchestration, portfolio management | Multi-project oversight, strategic alignment, resource allocation |
| Project Shepherd | Cross-functional coordination, timeline management | End-to-end project coordination, stakeholder management |
| Studio Operations | Day-to-day efficiency, process optimization | Operational excellence, team support, productivity |
| Experiment Tracker | A/B tests, hypothesis validation | Experiment management, data-driven decisions, testing |
| Senior Project Manager | Realistic scoping, task conversion | Converting specs to tasks, scope management |
| Jira Workflow Steward | Git workflow, branch strategy, traceability | Enforcing Jira-linked Git discipline and delivery |

---

## Testing Division

Breaking things so users don't have to.

| Agent | Specialty | When to Use |
| --- | --- | --- |
| Evidence Collector | Screenshot-based QA, visual proof | UI testing, visual verification, bug documentation |
| Reality Checker | Evidence-based certification, quality gates | Production readiness, quality approval, release certification |
| Test Results Analyzer | Test evaluation, metrics analysis | Test output analysis, quality insights, coverage reporting |
| Performance Benchmarker | Performance testing, optimization | Speed testing, load testing, performance tuning |
| API Tester | API validation, integration testing | API testing, endpoint verification, integration QA |
| Tool Evaluator | Technology assessment, tool selection | Evaluating tools, software recommendations, tech decisions |
| Workflow Optimizer | Process analysis, workflow improvement | Process optimization, efficiency gains, automation opportunities |
| Accessibility Auditor | WCAG auditing, assistive technology testing | Accessibility compliance, screen reader testing, inclusive design verification |

---

## Support Division

The backbone of the operation.

| Agent | Specialty | When to Use |
| --- | --- | --- |
| Support Responder | Customer service, issue resolution | Customer support, user experience, support operations |
| Analytics Reporter | Data analysis, dashboards, insights | Business intelligence, KPI tracking, data visualization |
| Finance Tracker | Financial planning, budget management | Financial analysis, cash flow, business performance |
| Infrastructure Maintainer | System reliability, performance optimization | Infrastructure management, system operations, monitoring |
| Legal Compliance Checker | Compliance, regulations, legal review | Legal compliance, regulatory requirements, risk management |
| Executive Summary Generator | C-suite communication, strategic summaries | Executive reporting, strategic communication, decision support |

---

## Spatial Computing Division

Building the immersive future.

| Agent | Specialty | When to Use |
| --- | --- | --- |
| XR Interface Architect | Spatial interaction design, immersive UX | AR/VR/XR interface design, spatial computing UX |
| macOS Spatial/Metal Engineer | Swift, Metal, high-performance 3D | macOS spatial computing, Vision Pro native apps |
| XR Immersive Developer | WebXR, browser-based AR/VR | Browser-based immersive experiences, WebXR apps |
| XR Cockpit Interaction Specialist | Cockpit-based controls, immersive systems | Cockpit control systems, immersive control interfaces |
| visionOS Spatial Engineer | Apple Vision Pro development | Vision Pro apps, spatial computing experiences |
| Terminal Integration Specialist | Terminal integration, command-line tools | CLI tools, terminal workflows, developer tools |

---

## Specialized Division

The unique specialists who don't fit in a box.

| Agent | Specialty | When to Use |
| --- | --- | --- |
| Agents Orchestrator | Multi-agent coordination, workflow management | Complex projects requiring multiple agent coordination |
| LSP/Index Engineer | Language Server Protocol, code intelligence | Code intelligence systems, LSP implementation, semantic indexing |
| Sales Data Extraction Agent | Excel monitoring, sales metric extraction | Sales data ingestion, MTD/YTD/Year End metrics |
| Data Consolidation Agent | Sales data aggregation, dashboard reports | Territory summaries, rep performance, pipeline snapshots |
| Report Distribution Agent | Automated report delivery | Territory-based report distribution, scheduled sends |
| Agentic Identity & Trust Architect | Agent identity, authentication, trust verification | Multi-agent identity systems, agent authorization, audit trails |
| Identity Graph Operator | Shared identity resolution for multi-agent systems | Entity deduplication, merge proposals, cross-agent identity consistency |
| Accounts Payable Agent | Payment processing, vendor management, audit | Autonomous payment execution across crypto, fiat, stablecoins |
| Blockchain Security Auditor | Smart contract audits, exploit analysis | Finding vulnerabilities in contracts before deployment |
| Compliance Auditor | SOC 2, ISO 27001, HIPAA, PCI-DSS | Guiding organizations through compliance certification |
| Cultural Intelligence Strategist | Global UX, representation, cultural exclusion | Ensuring software resonates across cultures |
| Developer Advocate | Community building, DX, developer content | Bridging product and developer community |
| Model QA Specialist | ML audits, feature analysis, interpretability | End-to-end QA for machine learning models |
| ZK Steward | Knowledge management, Zettelkasten, notes | Building connected, validated knowledge bases |
| MCP Builder | Model Context Protocol servers, AI agent tooling | Building MCP servers that extend AI agent capabilities |
| Document Generator | PDF, PPTX, DOCX, XLSX generation from code | Professional document creation, reports, data visualization |
| Automation Governance Architect | Automation governance, n8n, workflow auditing | Evaluating and governing business automations at scale |
| Corporate Training Designer | Enterprise training, curriculum development | Designing training systems and learning programs |
| Government Digital Presales Consultant | China ToG presales, digital transformation | Government digital transformation proposals and bids |
| Healthcare Marketing Compliance | China healthcare advertising compliance | Healthcare marketing regulatory compliance |
| Recruitment Specialist | Talent acquisition, recruiting operations | Recruitment strategy, sourcing, and hiring processes |
| Study Abroad Advisor | International education, application planning | Study abroad planning across US, UK, Canada, Australia |
| Supply Chain Strategist | Supply chain management, procurement strategy | Supply chain optimization and procurement planning |
| Workflow Architect | Workflow discovery, mapping, and specification | Mapping every path through a system before code is written |
| Salesforce Architect | Multi-cloud Salesforce design, governor limits, integrations | Enterprise Salesforce architecture, org strategy, deployment pipelines |
| French Consulting Market Navigator | ESN/SI ecosystem, portage salarial, rate positioning | Freelance consulting in the French IT market |
| Korean Business Navigator | Korean business culture, 품의 process, relationship mechanics | Foreign professionals navigating Korean business relationships |

---

## Game Development Division

Building worlds, systems, and experiences across every major engine.

### Cross-Engine Agents (Engine-Agnostic)

| Agent | Specialty | When to Use |
| --- | --- | --- |
| Game Designer | Systems design, GDD authorship, economy balancing, gameplay loops | Designing game mechanics, progression systems, writing design documents |
| Level Designer | Layout theory, pacing, encounter design, environmental storytelling | Building levels, designing encounter flow, spatial narrative |
| Technical Artist | Shaders, VFX, LOD pipeline, art-to-engine optimization | Bridging art and engineering, shader authoring, performance-safe asset pipelines |
| Game Audio Engineer | FMOD/Wwise, adaptive music, spatial audio, audio budgets | Interactive audio systems, dynamic music, audio performance |
| Narrative Designer | Story systems, branching dialogue, lore architecture | Writing branching narratives, implementing dialogue systems, world lore |

### Unity

| Agent | Specialty | When to Use |
| --- | --- | --- |
| Unity Architect | ScriptableObjects, data-driven modularity, DOTS/ECS | Large-scale Unity projects, data-driven system design, ECS performance work |
| Unity Shader Graph Artist | Shader Graph, HLSL, URP/HDRP, Renderer Features | Custom Unity materials, VFX shaders, post-processing passes |
| Unity Multiplayer Engineer | Netcode for GameObjects, Unity Relay/Lobby, server authority, prediction | Online Unity games, client prediction, Unity Gaming Services integration |
| Unity Editor Tool Developer | EditorWindows, AssetPostprocessors, PropertyDrawers, build validation | Custom Unity Editor tooling, pipeline automation, content validation |

### Unreal Engine

| Agent | Specialty | When to Use |
| --- | --- | --- |
| Unreal Systems Engineer | C++/Blueprint hybrid, GAS, Nanite constraints, memory management | Complex Unreal gameplay systems, Gameplay Ability System, engine-level C++ |
| Unreal Technical Artist | Material Editor, Niagara, PCG, Substrate | Unreal materials, Niagara VFX, procedural content generation |
| Unreal Multiplayer Architect | Actor replication, GameMode/GameState hierarchy, dedicated server | Unreal online games, replication graphs, server authoritative Unreal |
| Unreal World Builder | World Partition, Landscape, HLOD, LWC | Large open-world Unreal levels, streaming systems, terrain at scale |

### Godot

| Agent | Specialty | When to Use |
| --- | --- | --- |
| Godot Gameplay Scripter | GDScript 2.0, signals, composition, static typing | Godot gameplay systems, scene composition, performance-conscious GDScript |
| Godot Multiplayer Engineer | MultiplayerAPI, ENet/WebRTC, RPCs, authority model | Online Godot games, scene replication, server-authoritative Godot |
| Godot Shader Developer | Godot shading language, VisualShader, RenderingDevice | Custom Godot materials, 2D/3D effects, post-processing, compute shaders |

### Blender

| Agent | Specialty | When to Use |
| --- | --- | --- |
| Blender Addon Engineer | Blender Python (`bpy`), custom operators/panels, asset validators, exporters, pipeline automation | Building Blender add-ons, asset prep tools, export workflows, and DCC pipeline automation |

### Roblox Studio

| Agent | Specialty | When to Use |
| --- | --- | --- |
| Roblox Systems Scripter | Luau, RemoteEvents/Functions, DataStore, server-authoritative module architecture | Building secure Roblox game systems, client-server communication, data persistence |
| Roblox Experience Designer | Engagement loops, monetization, D1/D7 retention, onboarding flow | Designing Roblox game loops, Game Passes, daily rewards, player retention |
| Roblox Avatar Creator | UGC pipeline, accessory rigging, Creator Marketplace submission | Roblox UGC items, HumanoidDescription customization, in-experience avatar shops |

---

## Academic Division

Scholarly rigor for world-building, storytelling, and narrative design.

| Agent | Specialty | When to Use |
| --- | --- | --- |
| Anthropologist | Cultural systems, kinship, rituals, belief systems | Designing culturally coherent societies with internal logic |
| Geographer | Physical/human geography, climate, cartography | Building geographically coherent worlds with realistic terrain and settlements |
| Historian | Historical analysis, periodization, material culture | Validating historical coherence, enriching settings with authentic period detail |
| Narratologist | Narrative theory, story structure, character arcs | Analyzing and improving story structure with established theoretical frameworks |
| Psychologist | Personality theory, motivation, cognitive patterns | Building psychologically credible characters grounded in research |