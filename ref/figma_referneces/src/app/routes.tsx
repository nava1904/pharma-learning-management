import { createBrowserRouter } from "react-router";
import { Root } from "./components/Root";
import { Login } from "./components/Login";
import { EmployeeDashboard } from "./components/EmployeeDashboard";
import { CourseViewer } from "./components/CourseViewer";
import { Assessment } from "./components/Assessment";
import { Certificate } from "./components/Certificate";
import { AdminDashboard } from "./components/AdminDashboard";
import { CourseBuilder } from "./components/CourseBuilder";
import { QADashboard } from "./components/QADashboard";
import { AuditTrail } from "./components/AuditTrail";
import { ComplianceReport } from "./components/ComplianceReport";
import { SMEDashboard } from "./components/SMEDashboard";
import { NotFound } from "./components/NotFound";

export const router = createBrowserRouter([
  {
    path: "/",
    Component: Root,
    children: [
      { index: true, Component: Login },
      { path: "employee", Component: EmployeeDashboard },
      { path: "course/:courseId", Component: CourseViewer },
      { path: "assessment/:courseId", Component: Assessment },
      { path: "certificate/:certId", Component: Certificate },
      { path: "admin", Component: AdminDashboard },
      { path: "admin/course-builder/:courseId?", Component: CourseBuilder },
      { path: "qa", Component: QADashboard },
      { path: "qa/audit-trail", Component: AuditTrail },
      { path: "qa/compliance-report", Component: ComplianceReport },
      { path: "sme", Component: SMEDashboard },
      { path: "*", Component: NotFound },
    ],
  },
]);
