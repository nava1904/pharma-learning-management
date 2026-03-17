import { Award, Download, CheckCircle2, Lock } from 'lucide-react';

const certifications = [
  {
    id: 1,
    title: 'GMP Certified Professional',
    issueDate: 'March 10, 2026',
    status: 'earned',
    validUntil: 'March 10, 2028',
    score: 92
  },
  {
    id: 2,
    title: 'Safety SOP Specialist',
    issueDate: 'March 5, 2026',
    status: 'earned',
    validUntil: 'March 5, 2028',
    score: 88
  },
  {
    id: 3,
    title: 'Quality Control Expert',
    status: 'in-progress',
    progress: 65,
    requirements: 'Complete all modules and pass final exam with 80%+'
  },
  {
    id: 4,
    title: 'Regulatory Compliance Specialist',
    status: 'locked',
    requirements: 'Complete GMP, Safety SOP, and Quality Control certifications first'
  }
];

export function Certification() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-semibold mb-2">Certifications</h1>
        <p className="text-gray-600">Earn industry-recognized certifications</p>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-3 gap-6">
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm text-gray-600">Earned Certificates</h3>
            <Award className="w-5 h-5 text-emerald-600" />
          </div>
          <p className="text-3xl font-semibold">2</p>
        </div>
        
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm text-gray-600">In Progress</h3>
            <Award className="w-5 h-5 text-blue-600" />
          </div>
          <p className="text-3xl font-semibold">1</p>
        </div>
        
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm text-gray-600">Available</h3>
            <Award className="w-5 h-5 text-gray-400" />
          </div>
          <p className="text-3xl font-semibold">3</p>
        </div>
      </div>

      {/* Certifications List */}
      <div className="space-y-4">
        {certifications.map((cert) => (
          <div
            key={cert.id}
            className={`bg-white rounded-lg border border-gray-200 p-6 ${
              cert.status === 'locked' ? 'opacity-60' : ''
            }`}
          >
            <div className="flex items-start gap-6">
              {/* Certificate Icon */}
              <div
                className={`w-16 h-16 rounded-lg flex items-center justify-center flex-shrink-0 ${
                  cert.status === 'earned'
                    ? 'bg-emerald-100'
                    : cert.status === 'in-progress'
                    ? 'bg-blue-100'
                    : 'bg-gray-100'
                }`}
              >
                {cert.status === 'earned' ? (
                  <Award className="w-8 h-8 text-emerald-600" />
                ) : cert.status === 'locked' ? (
                  <Lock className="w-8 h-8 text-gray-400" />
                ) : (
                  <Award className="w-8 h-8 text-blue-600" />
                )}
              </div>

              {/* Certificate Info */}
              <div className="flex-1">
                <div className="flex items-start justify-between mb-2">
                  <div>
                    <h3 className="text-lg font-semibold mb-1">{cert.title}</h3>
                    {cert.status === 'earned' && (
                      <div className="flex items-center gap-4 text-sm text-gray-600">
                        <span>Issued: {cert.issueDate}</span>
                        <span>Valid until: {cert.validUntil}</span>
                        <span className="text-emerald-600 font-medium">Score: {cert.score}%</span>
                      </div>
                    )}
                    {cert.status === 'in-progress' && (
                      <p className="text-sm text-gray-600">{cert.requirements}</p>
                    )}
                    {cert.status === 'locked' && (
                      <p className="text-sm text-gray-600">{cert.requirements}</p>
                    )}
                  </div>
                  
                  {cert.status === 'earned' ? (
                    <div className="flex items-center gap-2">
                      <CheckCircle2 className="w-5 h-5 text-emerald-600" />
                      <span className="text-sm font-medium text-emerald-600">Earned</span>
                    </div>
                  ) : cert.status === 'in-progress' ? (
                    <span className="px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-sm font-medium">
                      In Progress
                    </span>
                  ) : (
                    <span className="px-3 py-1 bg-gray-100 text-gray-600 rounded-full text-sm font-medium">
                      Locked
                    </span>
                  )}
                </div>

                {/* Progress Bar for In-Progress */}
                {cert.status === 'in-progress' && cert.progress !== undefined && (
                  <div className="mb-4">
                    <div className="flex items-center justify-between text-sm mb-2">
                      <span className="text-gray-600">Completion Progress</span>
                      <span className="font-medium text-blue-600">{cert.progress}%</span>
                    </div>
                    <div className="w-full bg-gray-200 rounded-full h-2">
                      <div
                        className="bg-blue-600 h-2 rounded-full transition-all"
                        style={{ width: `${cert.progress}%` }}
                      />
                    </div>
                  </div>
                )}

                {/* Action Buttons */}
                {cert.status === 'earned' && (
                  <button className="flex items-center gap-2 px-4 py-2 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors mt-4">
                    <Download className="w-4 h-4" />
                    Download Certificate
                  </button>
                )}
                {cert.status === 'in-progress' && (
                  <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors mt-4">
                    Continue Learning
                  </button>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
