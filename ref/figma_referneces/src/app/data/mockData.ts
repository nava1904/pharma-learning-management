export interface User {
  id: string;
  name: string;
  role: "employee" | "admin" | "qa" | "sme";
  department: string;
  jobRole: string;
}

export interface Course {
  id: string;
  title: string;
  description: string;
  version: string;
  sopNumber: string;
  status: "draft" | "pending-qa" | "approved" | "archived";
  createdBy: string;
  createdDate: string;
  approvedBy?: string;
  approvedDate?: string;
  content: string;
  assessmentId?: string;
  minimumReadTime: number; // in seconds
  expiryMonths?: number;
}

export interface Assignment {
  id: string;
  courseId: string;
  userId: string;
  assignedDate: string;
  dueDate: string;
  status: "not-started" | "in-progress" | "completed" | "overdue";
  completedDate?: string;
  score?: number;
  certificationId?: string;
  priority: "low" | "medium" | "high";
}

export interface Assessment {
  id: string;
  courseId: string;
  questions: Question[];
  passingScore: number;
  randomize: boolean;
}

export interface Question {
  id: string;
  question: string;
  options: string[];
  correctAnswer: number;
}

export interface Certification {
  id: string;
  userId: string;
  courseId: string;
  issuedDate: string;
  expiryDate?: string;
  score: number;
  qrCode: string;
  signedBy: string;
}

export interface AuditLog {
  id: string;
  timestamp: string;
  userId: string;
  userName: string;
  action: string;
  details: string;
  ipAddress: string;
  ntpSync: boolean;
}

export interface ComplianceMetric {
  department: string;
  totalEmployees: number;
  compliant: number;
  overdue: number;
  upcoming: number;
  complianceRate: number;
}

// Mock Users
export const mockUsers: User[] = [
  {
    id: "emp001",
    name: "Anil Kumar",
    role: "employee",
    department: "Production",
    jobRole: "Filling Operator",
  },
  {
    id: "admin001",
    name: "Sarah Johnson",
    role: "admin",
    department: "Training",
    jobRole: "Training Administrator",
  },
  {
    id: "qa001",
    name: "Dr. Michael Chen",
    role: "qa",
    department: "Quality Assurance",
    jobRole: "QA Manager",
  },
  {
    id: "sme001",
    name: "Dr. Priya Sharma",
    role: "sme",
    department: "Manufacturing",
    jobRole: "Process Engineer SME",
  },
];

// Mock Courses
export const mockCourses: Course[] = [
  {
    id: "course001",
    title: "Sterile Filling SOP",
    description: "Standard Operating Procedure for aseptic filling operations",
    version: "3.0",
    sopNumber: "SOP-105",
    status: "approved",
    createdBy: "sme001",
    createdDate: "2026-02-15T10:00:00Z",
    approvedBy: "qa001",
    approvedDate: "2026-02-20T14:30:00Z",
    content: `# SOP-105: Sterile Filling Operations v3.0

## 1. Purpose
This SOP describes the procedures for aseptic filling operations to ensure product sterility and compliance with GMP requirements.

## 2. Scope
Applies to all personnel involved in sterile filling operations in clean rooms classified as Grade A/B.

## 3. Responsibilities
- Filling Operators: Execute filling operations
- QA: Monitor compliance and approve batch records
- Production Manager: Ensure adequate training

## 4. Procedure

### 4.1 Pre-operational Checks
1. Verify environmental monitoring data
2. Check HEPA filter integrity
3. Confirm room pressure differentials
4. Validate equipment calibration status

### 4.2 Gowning Procedure
1. Remove all jewelry and personal items
2. Don clean room garments in the gowning room
3. Perform hand hygiene
4. Don sterile gloves using aseptic technique

### 4.3 Filling Process
1. Transfer sterilized vials to filling line
2. Program filling volume parameters
3. Initiate automated filling sequence
4. Monitor fill weight every 15 minutes
5. Perform in-process quality checks

### 4.4 Critical Parameters
- Fill volume: 10.0 mL ± 0.5 mL
- Line speed: 200 vials/minute
- Temperature: 2-8°C
- Particulate count: ISO 5 classification

### 4.5 Deviation Management
Any deviation from specified parameters must be documented and reported to QA immediately.

## 5. References
- 21 CFR Part 211
- EU GMP Annex 1
- WHO Technical Report Series

## 6. Change History
- v3.0: Updated temperature range and added automated monitoring
- v2.0: Revised gowning procedure
- v1.0: Initial version`,
    assessmentId: "assess001",
    minimumReadTime: 300,
    expiryMonths: 12,
  },
  {
    id: "course002",
    title: "GMP Basics",
    description: "Good Manufacturing Practice fundamentals for pharmaceutical operations",
    version: "2.1",
    sopNumber: "SOP-001",
    status: "approved",
    createdBy: "sme001",
    createdDate: "2026-01-10T09:00:00Z",
    approvedBy: "qa001",
    approvedDate: "2026-01-15T11:00:00Z",
    content: `# SOP-001: Good Manufacturing Practice (GMP) Basics v2.1

## Introduction
Good Manufacturing Practice (GMP) is a system ensuring products are consistently produced and controlled according to quality standards.

## Core Principles

### 1. Quality Management
- Management responsibility for quality
- Quality Risk Management
- Quality systems and documentation

### 2. Personnel
- Adequate training for all staff
- Personal hygiene requirements
- Health monitoring programs

### 3. Premises and Equipment
- Designed for easy cleaning
- Maintained in good condition
- Validated before use

### 4. Documentation
- Written procedures for all operations
- Batch manufacturing records
- Standard Operating Procedures (SOPs)

### 5. Production
- Clear written procedures
- In-process controls
- Validation of critical steps

### 6. Quality Control
- Adequate testing facilities
- Approved test methods
- Stability monitoring

## ALCOA+ Principles
Data must be:
- Attributable: Who created it?
- Legible: Can it be read?
- Contemporaneous: Recorded in real-time?
- Original: First recording or certified copy?
- Accurate: Free from errors?
- Complete: All data present?
- Consistent: Chronological and logical?
- Enduring: Preserved long-term?
- Available: Retrievable for review?

## Regulatory Framework
- FDA 21 CFR Parts 210 & 211
- EU GMP Guidelines
- WHO GMP Guidelines
- ICH Q7 (API)`,
    assessmentId: "assess002",
    minimumReadTime: 240,
    expiryMonths: 24,
  },
  {
    id: "course003",
    title: "Data Integrity Training",
    description: "Understanding and maintaining data integrity in pharmaceutical operations",
    version: "1.0",
    sopNumber: "SOP-420",
    status: "approved",
    createdBy: "sme001",
    createdDate: "2026-03-01T10:00:00Z",
    approvedBy: "qa001",
    approvedDate: "2026-03-05T16:00:00Z",
    content: `# SOP-420: Data Integrity in Pharmaceutical Operations

## Purpose
To ensure all data generated in pharmaceutical operations maintains integrity and compliance with regulatory requirements.

## ALCOA+ Framework

### Attributable
- All data must be traceable to the person who created it
- Use unique user IDs
- No shared login credentials
- Electronic signatures required

### Legible
- Data must be readable throughout its lifecycle
- Use approved formats
- Maintain backup systems

### Contemporaneous
- Record data at the time of activity
- No backdating
- Time-stamped entries

### Original
- Maintain first recordings
- Certified copies only when necessary
- Audit trail for all changes

### Accurate
- Data reflects actual observations
- No fabrication or manipulation
- Complete and truthful

## Common Data Integrity Failures
1. Shared login credentials
2. Manipulation of audit trails
3. Uncontrolled data deletion
4. Lack of backup systems
5. Incomplete documentation

## Best Practices
- Use validated electronic systems
- Implement access controls
- Regular data reviews
- Training and awareness
- Audit trail review procedures`,
    assessmentId: "assess003",
    minimumReadTime: 180,
    expiryMonths: 12,
  },
  {
    id: "course004",
    title: "Deviation Management",
    description: "Procedures for identifying, documenting, and resolving manufacturing deviations",
    version: "1.5",
    sopNumber: "SOP-310",
    status: "approved",
    createdBy: "sme001",
    createdDate: "2026-02-20T11:00:00Z",
    approvedBy: "qa001",
    approvedDate: "2026-02-25T15:00:00Z",
    content: `# SOP-310: Deviation Management

## Purpose
To establish procedures for handling deviations from approved processes, specifications, or procedures.

## Definition
A deviation is any departure from approved instructions or established standards.

## Classification

### Critical Deviation
- Product quality potentially affected
- Patient safety concern
- GMP compliance issue
- Immediate action required

### Major Deviation
- Potential impact on product quality
- Process parameter excursion
- Investigation required

### Minor Deviation
- No impact on quality
- Isolated incident
- Documentation only

## Procedure

### 1. Identification
- Any employee can report a deviation
- Use Deviation Form DF-001
- Notify QA immediately for critical deviations

### 2. Documentation
- Describe what happened
- When it was discovered
- Who discovered it
- Immediate action taken

### 3. Investigation
- Root cause analysis
- Impact assessment
- Risk evaluation
- Determine batch disposition

### 4. CAPA
- Corrective Action: Fix the problem
- Preventive Action: Prevent recurrence
- Verify effectiveness
- Close deviation

## Training Requirements
Personnel involved in deviations must complete retraining on affected SOPs.`,
    assessmentId: "assess004",
    minimumReadTime: 200,
    expiryMonths: 12,
  },
  {
    id: "course005",
    title: "Safety Training",
    description: "Workplace safety procedures and emergency response",
    version: "4.0",
    sopNumber: "SOP-801",
    status: "approved",
    createdBy: "sme001",
    createdDate: "2026-01-05T08:00:00Z",
    approvedBy: "qa001",
    approvedDate: "2026-01-08T12:00:00Z",
    content: `# SOP-801: Workplace Safety and Emergency Procedures

## Purpose
Ensure all personnel understand safety requirements and emergency procedures.

## Personal Protective Equipment (PPE)

### Required PPE by Area
- Production: Safety glasses, lab coat, safety shoes, hair net
- Warehouse: Safety shoes, high-visibility vest, gloves
- Laboratory: Lab coat, safety glasses, gloves
- Clean Room: Full gowning per SOP-105

## Chemical Safety
- Review SDS before handling chemicals
- Use appropriate PPE
- Store chemicals per requirements
- Spill response procedures

## Emergency Procedures

### Fire Emergency
1. Activate fire alarm
2. Evacuate using nearest exit
3. Do not use elevators
4. Assemble at designated muster point
5. Do not re-enter until authorized

### Chemical Spill
1. Alert others in area
2. Evacuate if necessary
3. Contain spill if safe to do so
4. Contact EHS team
5. Complete incident report

### Medical Emergency
1. Call emergency number: 911
2. Provide first aid if trained
3. Do not move injured person unless necessary
4. Wait for emergency responders
5. Report to supervisor and EHS

## Reporting Requirements
All incidents, near-misses, and unsafe conditions must be reported within 24 hours.`,
    assessmentId: "assess005",
    minimumReadTime: 150,
    expiryMonths: 12,
  },
];

// Mock Assessments
export const mockAssessments: Assessment[] = [
  {
    id: "assess001",
    courseId: "course001",
    passingScore: 80,
    randomize: true,
    questions: [
      {
        id: "q001",
        question: "What is the acceptable fill volume range for sterile filling operations?",
        options: [
          "10.0 mL ± 0.2 mL",
          "10.0 mL ± 0.5 mL",
          "10.0 mL ± 1.0 mL",
          "10.0 mL ± 0.1 mL",
        ],
        correctAnswer: 1,
      },
      {
        id: "q002",
        question: "What should you do if you notice a deviation from specified parameters during filling?",
        options: [
          "Continue the process and document at the end of shift",
          "Document and report to QA immediately",
          "Stop the line and fix it yourself",
          "Wait until the batch is complete",
        ],
        correctAnswer: 1,
      },
      {
        id: "q003",
        question: "What is the required temperature range for the filling process?",
        options: ["0-5°C", "2-8°C", "5-10°C", "10-15°C"],
        correctAnswer: 1,
      },
      {
        id: "q004",
        question: "How often should fill weight be monitored during the filling process?",
        options: [
          "Every 5 minutes",
          "Every 15 minutes",
          "Every 30 minutes",
          "Every hour",
        ],
        correctAnswer: 1,
      },
      {
        id: "q005",
        question: "What is the first step in the gowning procedure?",
        options: [
          "Don sterile gloves",
          "Remove all jewelry and personal items",
          "Perform hand hygiene",
          "Don clean room garments",
        ],
        correctAnswer: 1,
      },
    ],
  },
  {
    id: "assess002",
    courseId: "course002",
    passingScore: 80,
    randomize: true,
    questions: [
      {
        id: "q006",
        question: "What does the 'A' in ALCOA+ stand for?",
        options: ["Accessible", "Attributable", "Approved", "Automated"],
        correctAnswer: 1,
      },
      {
        id: "q007",
        question: "Which regulatory framework governs pharmaceutical GMP in the United States?",
        options: [
          "ISO 9001",
          "21 CFR Parts 210 & 211",
          "EU GMP Guidelines",
          "ICH Q10",
        ],
        correctAnswer: 1,
      },
      {
        id: "q008",
        question: "What is the primary purpose of Good Manufacturing Practice?",
        options: [
          "To reduce manufacturing costs",
          "To ensure products are consistently produced according to quality standards",
          "To increase production speed",
          "To simplify documentation",
        ],
        correctAnswer: 1,
      },
      {
        id: "q009",
        question: "Which of the following is NOT a core GMP principle?",
        options: [
          "Quality Management",
          "Documentation",
          "Cost Reduction",
          "Personnel Training",
        ],
        correctAnswer: 2,
      },
      {
        id: "q010",
        question: "Data recorded in GMP operations must be:",
        options: [
          "Recorded at the end of the day",
          "Recorded contemporaneously (in real-time)",
          "Recorded weekly",
          "Recorded by supervisors only",
        ],
        correctAnswer: 1,
      },
    ],
  },
  {
    id: "assess003",
    courseId: "course003",
    passingScore: 85,
    randomize: true,
    questions: [
      {
        id: "q011",
        question: "Which of the following is a common data integrity failure?",
        options: [
          "Using unique login credentials",
          "Shared login credentials",
          "Complete documentation",
          "Regular backups",
        ],
        correctAnswer: 1,
      },
      {
        id: "q012",
        question: "What does 'Contemporaneous' mean in ALCOA+?",
        options: [
          "Data is modern",
          "Data is recorded at the time of activity",
          "Data is approved",
          "Data is digital",
        ],
        correctAnswer: 1,
      },
      {
        id: "q013",
        question: "Is backdating of data acceptable in pharmaceutical operations?",
        options: [
          "Yes, if approved by supervisor",
          "No, never",
          "Yes, for minor corrections",
          "Only during audits",
        ],
        correctAnswer: 1,
      },
      {
        id: "q014",
        question: "What is required for all electronic data entries?",
        options: [
          "Supervisor approval",
          "Unique user IDs and electronic signatures",
          "Paper copies",
          "Weekly review",
        ],
        correctAnswer: 1,
      },
      {
        id: "q015",
        question: "What should be maintained for all data changes?",
        options: [
          "Nothing special",
          "Audit trail",
          "Email notification",
          "Verbal confirmation",
        ],
        correctAnswer: 1,
      },
    ],
  },
  {
    id: "assess004",
    courseId: "course004",
    passingScore: 80,
    randomize: true,
    questions: [
      {
        id: "q016",
        question: "What is a deviation?",
        options: [
          "A planned change to a process",
          "Any departure from approved instructions or established standards",
          "A new SOP",
          "A training requirement",
        ],
        correctAnswer: 1,
      },
      {
        id: "q017",
        question: "Who can report a deviation?",
        options: [
          "Only QA personnel",
          "Only supervisors",
          "Any employee",
          "Only the production manager",
        ],
        correctAnswer: 2,
      },
      {
        id: "q018",
        question: "What is required for personnel involved in a deviation?",
        options: [
          "Termination",
          "Retraining on affected SOPs",
          "Transfer to another department",
          "Nothing special",
        ],
        correctAnswer: 1,
      },
      {
        id: "q019",
        question: "What does CAPA stand for?",
        options: [
          "Critical Analysis and Process Assessment",
          "Corrective Action and Preventive Action",
          "Compliance Audit and Performance Analysis",
          "Control Analysis and Product Approval",
        ],
        correctAnswer: 1,
      },
      {
        id: "q020",
        question: "When should QA be notified of a critical deviation?",
        options: [
          "Within 24 hours",
          "At the end of the week",
          "Immediately",
          "During the next scheduled meeting",
        ],
        correctAnswer: 2,
      },
    ],
  },
  {
    id: "assess005",
    courseId: "course005",
    passingScore: 80,
    randomize: true,
    questions: [
      {
        id: "q021",
        question: "What is the first step in a fire emergency?",
        options: [
          "Gather personal belongings",
          "Activate fire alarm",
          "Call your supervisor",
          "Use elevator to evacuate",
        ],
        correctAnswer: 1,
      },
      {
        id: "q022",
        question: "What should you do before handling any chemical?",
        options: [
          "Ask a coworker",
          "Review the Safety Data Sheet (SDS)",
          "Smell it to identify",
          "Nothing special",
        ],
        correctAnswer: 1,
      },
      {
        id: "q023",
        question: "Within what timeframe must incidents be reported?",
        options: [
          "Within 1 week",
          "Within 48 hours",
          "Within 24 hours",
          "Within 1 month",
        ],
        correctAnswer: 2,
      },
      {
        id: "q024",
        question: "What PPE is required in the production area?",
        options: [
          "Only safety shoes",
          "Safety glasses, lab coat, safety shoes, hair net",
          "Just a hair net",
          "No PPE required",
        ],
        correctAnswer: 1,
      },
      {
        id: "q025",
        question: "Should you use elevators during a fire emergency?",
        options: [
          "Yes, they are faster",
          "No, never",
          "Only if on upper floors",
          "Yes, if accompanied by supervisor",
        ],
        correctAnswer: 1,
      },
    ],
  },
];

// Mock Assignments
export const mockAssignments: Assignment[] = [
  {
    id: "assign001",
    courseId: "course001",
    userId: "emp001",
    assignedDate: "2026-02-21T09:00:00Z",
    dueDate: "2026-03-21T23:59:59Z",
    status: "in-progress",
    priority: "high",
  },
  {
    id: "assign002",
    courseId: "course002",
    userId: "emp001",
    assignedDate: "2026-01-16T09:00:00Z",
    dueDate: "2026-02-16T23:59:59Z",
    status: "completed",
    completedDate: "2026-02-10T14:30:00Z",
    score: 95,
    certificationId: "cert001",
    priority: "medium",
  },
  {
    id: "assign003",
    courseId: "course003",
    userId: "emp001",
    assignedDate: "2026-03-06T09:00:00Z",
    dueDate: "2026-03-20T23:59:59Z",
    status: "not-started",
    priority: "high",
  },
  {
    id: "assign004",
    courseId: "course005",
    userId: "emp001",
    assignedDate: "2026-01-09T09:00:00Z",
    dueDate: "2026-02-09T23:59:59Z",
    status: "completed",
    completedDate: "2026-01-25T11:15:00Z",
    score: 100,
    certificationId: "cert002",
    priority: "high",
  },
];

// Mock Certifications
export const mockCertifications: Certification[] = [
  {
    id: "cert001",
    userId: "emp001",
    courseId: "course002",
    issuedDate: "2026-02-10T14:30:00Z",
    expiryDate: "2028-02-10T14:30:00Z",
    score: 95,
    qrCode: "QR-CERT-001-2026-02-10",
    signedBy: "qa001",
  },
  {
    id: "cert002",
    userId: "emp001",
    courseId: "course005",
    issuedDate: "2026-01-25T11:15:00Z",
    expiryDate: "2027-01-25T11:15:00Z",
    score: 100,
    qrCode: "QR-CERT-002-2026-01-25",
    signedBy: "qa001",
  },
];

// Mock Audit Logs
export const mockAuditLogs: AuditLog[] = [
  {
    id: "audit001",
    timestamp: "2026-03-06T10:15:32.456Z",
    userId: "emp001",
    userName: "Anil Kumar",
    action: "LOGIN",
    details: "User logged into LMS",
    ipAddress: "192.168.1.45",
    ntpSync: true,
  },
  {
    id: "audit002",
    timestamp: "2026-03-06T10:16:05.123Z",
    userId: "emp001",
    userName: "Anil Kumar",
    action: "COURSE_ACCESS",
    details: "Accessed course: Sterile Filling SOP (SOP-105 v3.0)",
    ipAddress: "192.168.1.45",
    ntpSync: true,
  },
  {
    id: "audit003",
    timestamp: "2026-02-21T09:00:00.000Z",
    userId: "admin001",
    userName: "Sarah Johnson",
    action: "TRAINING_ASSIGNED",
    details: "Assigned 'Sterile Filling SOP' to Anil Kumar - Reason: SOP Update v2.0 → v3.0",
    ipAddress: "192.168.1.100",
    ntpSync: true,
  },
  {
    id: "audit004",
    timestamp: "2026-02-20T14:30:00.000Z",
    userId: "qa001",
    userName: "Dr. Michael Chen",
    action: "COURSE_APPROVED",
    details: "Approved course 'Sterile Filling SOP' v3.0 for release - Signature: 'Approval of Training Content'",
    ipAddress: "192.168.1.50",
    ntpSync: true,
  },
  {
    id: "audit005",
    timestamp: "2026-02-10T14:30:00.000Z",
    userId: "emp001",
    userName: "Anil Kumar",
    action: "ASSESSMENT_COMPLETED",
    details: "Completed assessment for 'GMP Basics' - Score: 95% (Pass)",
    ipAddress: "192.168.1.45",
    ntpSync: true,
  },
  {
    id: "audit006",
    timestamp: "2026-02-10T14:30:15.789Z",
    userId: "emp001",
    userName: "Anil Kumar",
    action: "ELECTRONIC_SIGNATURE",
    details: "Electronically signed training completion for 'GMP Basics' - Intent: 'Acknowledgment of Training Completion'",
    ipAddress: "192.168.1.45",
    ntpSync: true,
  },
  {
    id: "audit007",
    timestamp: "2026-02-10T14:30:30.456Z",
    userId: "qa001",
    userName: "Dr. Michael Chen",
    action: "CERTIFICATE_ISSUED",
    details: "Issued certificate CERT001 to Anil Kumar for 'GMP Basics'",
    ipAddress: "192.168.1.50",
    ntpSync: true,
  },
  {
    id: "audit008",
    timestamp: "2026-03-05T16:00:00.000Z",
    userId: "qa001",
    userName: "Dr. Michael Chen",
    action: "COURSE_APPROVED",
    details: "Approved course 'Data Integrity Training' v1.0 for release",
    ipAddress: "192.168.1.50",
    ntpSync: true,
  },
];

// Mock Compliance Metrics
export const mockComplianceMetrics: ComplianceMetric[] = [
  {
    department: "Production",
    totalEmployees: 45,
    compliant: 38,
    overdue: 5,
    upcoming: 2,
    complianceRate: 84.4,
  },
  {
    department: "Quality Assurance",
    totalEmployees: 12,
    compliant: 12,
    overdue: 0,
    upcoming: 0,
    complianceRate: 100,
  },
  {
    department: "Warehouse",
    totalEmployees: 28,
    compliant: 27,
    overdue: 1,
    upcoming: 0,
    complianceRate: 96.4,
  },
  {
    department: "Laboratory",
    totalEmployees: 18,
    compliant: 17,
    overdue: 0,
    upcoming: 1,
    complianceRate: 94.4,
  },
  {
    department: "Engineering",
    totalEmployees: 15,
    compliant: 14,
    overdue: 1,
    upcoming: 0,
    complianceRate: 93.3,
  },
];
