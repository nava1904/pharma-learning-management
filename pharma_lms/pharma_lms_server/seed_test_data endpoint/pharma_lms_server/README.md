# Pharma Learning Management System Server

## Overview
The Pharma Learning Management System (LMS) Server is designed to manage and facilitate training and compliance within the pharmaceutical industry. This server handles user management, course administration, and data analytics to ensure that all training requirements are met efficiently.

## Seed Data Script
The project includes a seed data script located at `lib/src/seed_scripts/pharma_realistic_seed.dart`. This script populates the database with realistic data for testing purposes. It creates:

- **200 Learners**: Each learner is assigned realistic attributes to simulate actual users in a pharmaceutical training environment.
- **10 Admin Roles**: These roles are designed to manage various aspects of the LMS, ensuring that all functionalities are tested.

## Running the Seed Script
To run the seed script, follow these steps:

1. Ensure that your database is set up and running.
2. Navigate to the project directory in your terminal.
3. Execute the following command to run the seed script:

   ```
   dart run lib/src/seed_scripts/pharma_realistic_seed.dart
   ```

4. Monitor the output for any errors or confirmations of successful data insertion.

## Data Structure
The database is structured to accommodate various entities, including:

- **Learners**: Each learner has attributes such as name, email, password, role, and training progress.
- **Admin Roles**: Admin roles include permissions for managing users, courses, and analytics.
- **Courses**: Courses are linked to learners and include details such as course name, description, and completion status.

## Contribution
Contributions to the Pharma LMS Server are welcome. Please follow the standard practices for submitting issues and pull requests.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.