import { useParams, useNavigate, useSearchParams } from "react-router";
import { mockCertifications, mockCourses, mockUsers } from "../data/mockData";
import { Award, Download, ArrowLeft, CheckCircle2, QrCode } from "lucide-react";

export function Certificate() {
  const { certId } = useParams();
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();

  // Check if this is a new certificate from assessment
  const scoreParam = searchParams.get("score");
  const courseIdParam = searchParams.get("courseId");

  let certificate = mockCertifications.find((c) => c.id === certId);
  let course = certificate
    ? mockCourses.find((c) => c.id === certificate.courseId)
    : null;
  let user = certificate ? mockUsers.find((u) => u.id === certificate.userId) : null;

  // If coming from assessment, create a temporary certificate
  if (scoreParam && courseIdParam && !certificate) {
    const tempCourse = mockCourses.find((c) => c.id === courseIdParam);
    const currentUser = mockUsers[0];

    if (tempCourse) {
      const issuedDate = new Date().toISOString();
      const expiryDate = tempCourse.expiryMonths
        ? new Date(
            new Date().setMonth(new Date().getMonth() + tempCourse.expiryMonths)
          ).toISOString()
        : undefined;

      certificate = {
        id: certId || `cert-${Date.now()}`,
        userId: currentUser.id,
        courseId: tempCourse.id,
        issuedDate,
        expiryDate,
        score: parseInt(scoreParam),
        qrCode: `QR-${certId}-${new Date().toISOString().split("T")[0]}`,
        signedBy: "qa001",
      };
      course = tempCourse;
      user = currentUser;
    }
  }

  if (!certificate || !course || !user) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-slate-50">
        <div className="text-center">
          <Award className="size-12 text-slate-400 mx-auto mb-4" />
          <h2 className="text-xl font-semibold text-slate-900">
            Certificate Not Found
          </h2>
          <button
            onClick={() => navigate("/employee")}
            className="mt-4 px-4 py-2 bg-indigo-600 text-white rounded-lg"
          >
            Back to Dashboard
          </button>
        </div>
      </div>
    );
  }

  const qaUser = mockUsers.find((u) => u.id === certificate.signedBy);

  return (
    <div className="min-h-screen bg-slate-50 py-8">
      <div className="max-w-4xl mx-auto px-6">
        <div className="mb-6 flex items-center justify-between">
          <button
            onClick={() => navigate("/employee")}
            className="flex items-center gap-2 text-slate-600 hover:text-slate-900"
          >
            <ArrowLeft className="size-4" />
            <span className="text-sm">Back to Dashboard</span>
          </button>
          <button className="flex items-center gap-2 px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700">
            <Download className="size-4" />
            <span className="text-sm">Download PDF</span>
          </button>
        </div>

        {/* Success Message */}
        <div className="bg-green-50 border border-green-200 rounded-lg p-4 mb-6">
          <div className="flex items-center gap-3">
            <CheckCircle2 className="size-5 text-green-600" />
            <div>
              <p className="font-semibold text-green-900">
                Training Completed Successfully
              </p>
              <p className="text-sm text-green-700">
                Your certificate has been generated and recorded in the audit trail.
              </p>
            </div>
          </div>
        </div>

        {/* Certificate */}
        <div className="bg-white border-4 border-amber-400 rounded-lg p-12 shadow-lg">
          {/* Header */}
          <div className="text-center mb-8">
            <div className="inline-flex items-center justify-center size-20 bg-amber-100 rounded-full mb-4">
              <Award className="size-10 text-amber-600" />
            </div>
            <h1 className="text-3xl font-bold text-slate-900 mb-2">
              Certificate of Completion
            </h1>
            <p className="text-slate-600">
              This certifies that the following individual has successfully completed
              the required training
            </p>
          </div>

          {/* Employee Info */}
          <div className="text-center mb-8 py-6 border-y-2 border-slate-200">
            <p className="text-sm text-slate-600 mb-2">This is to certify that</p>
            <p className="text-3xl font-bold text-indigo-600 mb-2">{user.name}</p>
            <p className="text-slate-600">
              {user.jobRole} - {user.department}
            </p>
          </div>

          {/* Course Info */}
          <div className="mb-8">
            <p className="text-center text-slate-600 mb-4">
              has successfully completed the training course
            </p>
            <div className="bg-slate-50 rounded-lg p-6 text-center">
              <h2 className="text-2xl font-bold text-slate-900 mb-2">
                {course.title}
              </h2>
              <p className="text-slate-600 mb-3">{course.description}</p>
              <div className="flex items-center justify-center gap-6 text-sm text-slate-600">
                <span>
                  {course.sopNumber} v{course.version}
                </span>
                <span>•</span>
                <span>Score: {certificate.score}%</span>
              </div>
            </div>
          </div>

          {/* Dates and Signatures */}
          <div className="grid grid-cols-2 gap-8 mb-8">
            <div>
              <p className="text-sm text-slate-600 mb-2">Date of Issuance</p>
              <p className="font-semibold text-slate-900">
                {new Date(certificate.issuedDate).toLocaleDateString("en-US", {
                  year: "numeric",
                  month: "long",
                  day: "numeric",
                })}
              </p>
            </div>
            {certificate.expiryDate && (
              <div>
                <p className="text-sm text-slate-600 mb-2">Expiry Date</p>
                <p className="font-semibold text-slate-900">
                  {new Date(certificate.expiryDate).toLocaleDateString("en-US", {
                    year: "numeric",
                    month: "long",
                    day: "numeric",
                  })}
                </p>
              </div>
            )}
          </div>

          {/* Signature Section */}
          <div className="grid grid-cols-2 gap-8 pt-8 border-t border-slate-200 mb-8">
            <div>
              <div className="border-b-2 border-slate-900 pb-2 mb-2">
                <p className="font-bold text-slate-900 text-lg">{user.name}</p>
              </div>
              <p className="text-sm text-slate-600">Employee Signature</p>
              <p className="text-xs text-slate-500 mt-1">
                Electronically signed on{" "}
                {new Date(certificate.issuedDate).toLocaleString()}
              </p>
            </div>
            <div>
              <div className="border-b-2 border-slate-900 pb-2 mb-2">
                <p className="font-bold text-slate-900 text-lg">{qaUser?.name}</p>
              </div>
              <p className="text-sm text-slate-600">Authorized Approver</p>
              <p className="text-xs text-slate-500 mt-1">Quality Assurance</p>
            </div>
          </div>

          {/* QR Code and Certificate ID */}
          <div className="flex items-end justify-between">
            <div>
              <p className="text-sm text-slate-600 mb-1">Certificate ID</p>
              <p className="text-xs font-mono text-slate-900">
                {certificate.id.toUpperCase()}
              </p>
              <p className="text-xs text-slate-500 mt-2">
                21 CFR Part 11 Compliant
              </p>
            </div>
            <div className="text-center">
              <div className="size-24 bg-slate-200 rounded-lg flex items-center justify-center mb-2">
                <QrCode className="size-12 text-slate-400" />
              </div>
              <p className="text-xs text-slate-500">{certificate.qrCode}</p>
            </div>
          </div>
        </div>

        {/* Audit Trail Reference */}
        <div className="mt-6 bg-blue-50 border border-blue-200 rounded-lg p-4">
          <p className="text-sm text-blue-900">
            <span className="font-semibold">Audit Trail Reference:</span> This
            certificate issuance has been recorded in the immutable audit trail with
            NTP-synchronized timestamp. All signatures are electronically verified
            and stored per regulatory requirements.
          </p>
        </div>
      </div>
    </div>
  );
}
