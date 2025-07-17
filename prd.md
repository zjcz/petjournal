# Product Requirements Document: Pet Journal

**Author:** Gemini AI

**Date:** 2024-07-15

**Version:** 1.0

## 1. Introduction

This document outlines the product requirements for the Pet Journal mobile application. This app allows users to store and manage important information about their pets. This document is generated based on an analysis of the existing codebase.

## 2. Functional Requirements

### 2.1 User Onboarding

*   **FR-001: Welcome Screen:** The app shall present a welcome screen to new users.
*   **FR-002: Terms and Conditions:** Users must accept the terms and conditions before using the app.
*   **FR-003: Privacy Policy:** Users must be presented with a privacy policy.
*   **FR-004: Analytics Opt-in:** Users shall have the option to opt into analytics.

### 2.2 Pet Management

*   **FR-005: Add a New Pet:** Users shall be able to add a new pet to the journal.
*   **FR-006: Edit Pet Information:** Users shall be able to edit the information of an existing pet.
*   **FR-007: View Pet Information:** Users shall be able to view the detailed information of a pet.
*   **FR-008: Delete a Pet:** Users shall be able to delete a pet from the journal.
*   **FR-009: List All Pets:** The app shall display a list of all pets added by the user.

### 2.3 Pet Information

The following information can be stored for each pet:

*   **FR-010: Basic Information:**
    *   Name (Required)
    *   Species (Required)
    *   Breed (Required)
    *   Colour (Required)
    *   Sex (Required)
    *   Date of Birth (Optional)
    *   Date of Birth is an estimate (Optional)
    *   Status (e.g., Active, Deceased) (Required)
*   **FR-011: Health & Care:**
    *   Is Neutered/Spayed (Optional)
    *   Neuter/Spay Date (Optional, required if neutered)
    *   Diet (Optional)
*   **FR-012: Microchip Information:**
    *   Is Microchipped (Optional)
    *   Microchip Number (Optional, required if microchipped)
    *   Microchip Company (Optional)
    *   Microchip Date (Optional)
    *   Microchip Notes (Optional)
*   **FR-013: Additional Notes:**
    *   General Notes (Optional)
    *   History (Optional)

### 2.4 Medical Information

*   **FR-014: Medications:** Users shall be able to record and view medications for each pet, including:
    *   Name
    *   Dose
    *   Start Date
    *   End Date
    *   Notes
*   **FR-015: Vaccinations:** Users shall be able to record and view vaccinations for each pet, including:
    *   Name
    *   Administered Date
    *   Expiry Date
    *   Reminder Date
    *   Notes
    *   Vaccine Batch Number
    *   Vaccine Manufacturer
    *   Administered By

### 2.5 Weight Tracking

*   **FR-016: Record Weight:** Users shall be able to record and view weight entries for each pet, including:
    *   Date
    *   Weight
    *   Weight Unit (e.g., kg, lbs)
    *   Notes

### 2.6 Journal

*   **FR-017: Journal Entries:** Users shall be able to create and view journal entries for each pet. (Note: The UI for this feature is not yet implemented).

### 2.7 Settings

*   **FR-018: User Settings:** Users shall be able to configure the following settings:
    *   Default Weight Unit
    *   Analytics Opt-in
*   **FR-019: Delete All Data:** Users shall have the option to delete all data in the app.

### 2.8 About Screen

*   **FR-020: App Information:** The app shall have an "About" screen that displays:
    *   App Name
    *   Company Name
    *   Version and Build Number
*   **FR-021: Links:** The "About" screen shall provide links to:
    *   Website
    *   Terms and Conditions
    *   Privacy Policy
    *   3rd Party Licenses

## 3. Non-Functional Requirements

*   **NFR-001: Platform:** The application is a Flutter-based mobile app, targeting Android and iOS.
*   **NFR-002: Database:** The application shall use a local SQLite database (via Drift) to store all data.
*   **NFR-003: State Management:** The application shall use Riverpod for state management.
*   **NFR-004: Navigation:** The application shall use go\_router for navigation.

## 4. Future Development (Based on Code Analysis)

The codebase includes placeholders and stubs for the following features, which are not yet fully implemented:

*   **Journal:** The UI for adding and viewing journal entries is not yet implemented.
*   **Analytics:** The analytics helper is commented out, suggesting that analytics integration is not yet complete.
