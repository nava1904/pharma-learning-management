import { createBrowserRouter } from "react-router";
import { DashboardLayout } from "./components/DashboardLayout";
import { Overview } from "./pages/Overview";
import { Courses } from "./pages/Courses";
import { Lessons } from "./pages/Lessons";
import { Assessments } from "./pages/Assessments";
import { Challenges } from "./pages/Challenges";
import { Certification } from "./pages/Certification";
import { Project } from "./pages/Project";
import { Download } from "./pages/Download";
import { CourseDetail } from "./pages/CourseDetail";
import { AssessmentStart } from "./pages/AssessmentStart";
import { TrainingHistory } from "./pages/TrainingHistory";

export const router = createBrowserRouter([
  {
    path: "/",
    Component: DashboardLayout,
    children: [
      { index: true, Component: Overview },
      { path: "courses", Component: Courses },
      { path: "courses/:id", Component: CourseDetail },
      { path: "lessons", Component: Lessons },
      { path: "assessments", Component: Assessments },
      { path: "assessments/:id", Component: AssessmentStart },
      { path: "challenges", Component: Challenges },
      { path: "certification", Component: Certification },
      { path: "project", Component: Project },
      { path: "download", Component: Download },
      { path: "history", Component: TrainingHistory },
    ],
  },
]);
