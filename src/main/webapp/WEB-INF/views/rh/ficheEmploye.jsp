<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Fiche Employé - BusinessSuite</title>
    <style>
        :root {
            --navy-blue: #1A365D;
            --navy-light: #2D4A7C;
            --navy-dark: #0F1F3D;
            --cream: #F8F9FA;
            --cream-dark: #E9ECEF;
            --white: #FFFFFF;
            --gray: #6C757D;
            --gray-light: #DEE2E6;
            --gray-lighter: #F8F9FA;
            --accent: #2563EB;
            --success: #198754;
            --warning: #ffc107;
            --danger: #dc3545;
            --info: #0dcaf0;
            --border-radius: 8px;
            --box-shadow: 0 2px 15px rgba(26, 54, 93, 0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Segoe UI', sans-serif;
            line-height: 1.6;
            color: var(--navy-blue);
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            min-height: 100vh;
        }

        .main-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding: 1.5rem;
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
        }

        .page-title h2 {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--navy-blue);
            margin-bottom: 0.25rem;
        }

        .page-title p {
            color: var(--gray);
            font-size: 0.9rem;
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .back-btn, .logout-btn {
            background: var(--navy-blue);
            color: var(--white);
            padding: 0.75rem 1.5rem;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.875rem;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 2px 5px rgba(26, 54, 93, 0.2);
        }

        .back-btn:hover, .logout-btn:hover {
            background: var(--navy-light);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(26, 54, 93, 0.3);
        }

        /* Messages d'alerte */
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1rem;
            border-left: 4px solid var(--danger);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1rem;
            border-left: 4px solid var(--success);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Layout Fiche Employé */
        .fiche-container {
            display: grid;
            grid-template-columns: 350px 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        /* Côté gauche - Photo et Info basique */
        .fiche-sidebar {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 2rem;
            text-align: center;
            height: fit-content;
            position: sticky;
            top: 2rem;
        }

        .photo-container {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .avatar-placeholder {
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--navy-blue) 0%, var(--navy-light) 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
            margin: 0 auto 1rem;
            border: 4px solid var(--navy-blue);
            box-shadow: 0 4px 15px rgba(26, 54, 93, 0.3);
        }

        .upload-btn {
            background: var(--accent);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: var(--border-radius);
            cursor: pointer;
            font-size: 0.9rem;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin: 0 auto;
            box-shadow: 0 2px 5px rgba(37, 99, 235, 0.3);
        }

        .upload-btn:hover {
            background: var(--navy-blue);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(37, 99, 235, 0.4);
        }

        .employe-nom {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--navy-blue);
            margin-bottom: 0.5rem;
        }

        .employe-poste {
            color: var(--gray);
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        .badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
            display: inline-block;
        }

        .badge-success {
            background: var(--success);
            color: white;
        }

        .badge-warning {
            background: var(--warning);
            color: black;
        }

        .badge-danger {
            background: var(--danger);
            color: white;
        }

        .badge-info {
            background: var(--info);
            color: black;
        }

        .badge-secondary {
            background: var(--gray-light);
            color: var(--gray);
        }

        /* Côté droit - Détails */
        .fiche-content {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 2rem;
        }

        /* Onglets */
        .tabs {
            display: flex;
            border-bottom: 1px solid var(--gray-light);
            margin-bottom: 2rem;
            background: var(--gray-lighter);
            border-radius: var(--border-radius) var(--border-radius) 0 0;
            overflow: hidden;
        }

        .tab {
            padding: 1rem 2rem;
            background: none;
            border: none;
            cursor: pointer;
            font-weight: 500;
            color: var(--gray);
            border-bottom: 3px solid transparent;
            transition: var(--transition);
            flex: 1;
            text-align: center;
        }

        .tab.active {
            color: var(--navy-blue);
            border-bottom-color: var(--navy-blue);
            background: var(--white);
        }

        .tab:hover {
            color: var(--navy-blue);
            background: var(--cream);
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        /* Sections */
        .section {
            margin-bottom: 2rem;
            padding: 1.5rem;
            background: var(--gray-lighter);
            border-radius: var(--border-radius);
            border-left: 4px solid var(--navy-blue);
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--navy-blue);
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid var(--gray-light);
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
        }

        .info-item {
            display: flex;
            flex-direction: column;
            padding: 0.75rem;
            background: var(--white);
            border-radius: var(--border-radius);
            border: 1px solid var(--gray-light);
            transition: var(--transition);
        }

        .info-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        }

        .info-label {
            font-size: 0.875rem;
            color: var(--gray);
            margin-bottom: 0.25rem;
            font-weight: 500;
        }

        .info-value {
            font-weight: 600;
            color: var(--navy-blue);
        }

        /* Style pour les valeurs vides */
        .empty-value {
            color: var(--gray);
            font-style: italic;
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .fiche-container {
                grid-template-columns: 300px 1fr;
            }
        }

        @media (max-width: 992px) {
            .fiche-container {
                grid-template-columns: 1fr;
            }
            .fiche-sidebar {
                position: static;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }
            .tabs {
                flex-direction: column;
            }
            .tab {
                padding: 0.75rem 1rem;
            }
            .info-grid {
                grid-template-columns: 1fr;
            }
            .top-bar {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
            .user-menu {
                flex-direction: column;
                width: 100%;
            }
            .back-btn, .logout-btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 576px) {
            .top-bar {
                padding: 1rem;
            }
            .page-title h2 {
                font-size: 1.5rem;
            }
            .avatar-placeholder {
                width: 150px;
                height: 150px;
                font-size: 3rem;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="admin-container">
        <!-- Contenu Principal -->
        <main class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <div class="page-title">
                    <h2>Fiche Employé</h2>
                    <p>Informations complètes de ${employe.prenom} ${employe.nom}</p>
                </div>
                <div class="user-menu">
                    <a href="${pageContext.request.contextPath}/rh/employe" class="back-btn">
                        <i class="fas fa-arrow-left"></i>
                        Retour aux employés
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i>
                        Déconnexion
                    </a>
                </div>
            </div>

            <!-- Messages d'alerte -->
            <c:if test="${not empty error}">
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="success-message">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>

            <!-- Fiche Employé -->
            <div class="fiche-container">
                <!-- Côté gauche - Photo et info basique -->
                <div class="fiche-sidebar">
                    <div class="photo-container">
                        <!-- VERSION SANS BOUCLE - Placeholder fixe -->
                        <div class="avatar-placeholder">
                            <i class="fas fa-user-tie"></i>
                        </div>
                        
                        <!-- Formulaire d'upload de photo -->
                        <form action="${pageContext.request.contextPath}/rh/fiche-employe/upload-photo" 
                              method="post" enctype="multipart/form-data" id="uploadForm">
                            <input type="hidden" name="id_employe" value="${employe.id}">
                            <input type="file" name="file" id="fileInput" accept="image/*" style="display: none;" 
                                   onchange="document.getElementById('uploadForm').submit()">
                            <button type="button" class="upload-btn" onclick="document.getElementById('fileInput').click()">
                                <i class="fas fa-camera"></i> Ajouter une photo
                            </button>
                        </form>
                    </div>

                    <h1 class="employe-nom">${employe.prenom} ${employe.nom}</h1>
                    <p class="employe-poste">${employe.poste}</p>
                    
                    <div style="margin-bottom: 1rem;">
                        <span class="badge ${employe.statut == 'actif' ? 'badge-success' : 'badge-danger'}">
                            ${employe.statut}
                        </span>
                        <c:if test="${not empty employe.typeContrat}">
                            <span class="badge badge-info" style="margin-left: 0.5rem;">
                                ${employe.typeContrat}
                            </span>
                        </c:if>
                    </div>

                    <div class="info-grid" style="text-align: left; margin-top: 1.5rem;">
                        <div class="info-item">
                            <span class="info-label">Âge</span>
                            <span class="info-value">
                                <c:choose>
                                    <c:when test="${not empty employe.age}">${employe.age} ans</c:when>
                                    <c:otherwise><span class="empty-value">Non renseigné</span></c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Ancienneté</span>
                            <span class="info-value">
                                <c:choose>
                                    <c:when test="${not empty employe.ancienneteAnnees}">${employe.ancienneteAnnees} an(s)</c:when>
                                    <c:otherwise><span class="empty-value">Non renseigné</span></c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Département</span>
                            <span class="info-value">
                                <c:choose>
                                    <c:when test="${not empty employe.departement}">${employe.departement}</c:when>
                                    <c:otherwise><span class="empty-value">Non renseigné</span></c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Date embauche</span>
                            <span class="info-value">
                                <c:choose>
                                    <c:when test="${not empty employe.dateEmbauche}">${employe.dateEmbauche}</c:when>
                                    <c:otherwise><span class="empty-value">Non renseigné</span></c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Côté droit - Détails avec onglets -->
                <div class="fiche-content">
                    <!-- Onglets -->
                    <div class="tabs">
                        <button class="tab active" onclick="openTab('identite')">Identité</button>
                        <button class="tab" onclick="openTab('professionnel')">Professionnel</button>
                        <button class="tab" onclick="openTab('contact')">Contact</button>
                        <button class="tab" onclick="openTab('contrat')">Contrat</button>
                    </div>

                    <!-- Onglet Identité -->
                    <div id="identite" class="tab-content active">
                        <div class="section">
                            <h3 class="section-title">Informations Personnelles</h3>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">Nom complet</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty employe.prenom || not empty employe.nom}">
                                                ${employe.prenom} ${employe.nom}
                                            </c:when>
                                            <c:otherwise><span class="empty-value">Non renseigné</span></c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Date de naissance</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty employe.dateNaissance}">
                                                ${employe.dateNaissance} (${employe.age} ans)
                                            </c:when>
                                            <c:otherwise><span class="empty-value">Non renseigné</span></c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Email</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty employe.mail}">${employe.mail}</c:when>
                                            <c:otherwise><span class="empty-value">Non renseigné</span></c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Adresse</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty employe.adresse}">${employe.adresse}</c:when>
                                            <c:otherwise><span class="empty-value">Non renseigné</span></c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="section">
                            <h3 class="section-title">Formation & Expérience</h3>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">Diplôme</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty employe.diplome}">${employe.diplome}</c:when>
                                            <c:otherwise><span class="empty-value">Non renseigné</span></c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Années d'expérience</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty employe.anneeExperience}">${employe.anneeExperience} an(s)</c:when>
                                            <c:otherwise><span class="empty-value">Non renseigné</span></c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <c:if test="${not empty employe.renseignement}">
                            <div class="section">
                                <h3 class="section-title">Informations complémentaires</h3>
                                <div class="info-item">
                                    <span class="info-value">${employe.renseignement}</span>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- Onglet Professionnel -->
                    <div id="professionnel" class="tab-content">
                        <div class="section">
                            <h3 class="section-title">Poste Actuel</h3>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">Poste</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty employe.poste}">${employe.poste}</c:when>
                                            <c:otherwise><span class="empty-value">Non renseigné</span></c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Département</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty employe.departement}">${employe.departement}</c:when>
                                            <c:otherwise><span class="empty-value">Non renseigné</span></c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Date d'embauche</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty employe.dateEmbauche}">${employe.dateEmbauche}</c:when>
                                            <c:otherwise><span class="empty-value">Non renseigné</span></c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Ancienneté</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty employe.ancienneteAnnees}">${employe.ancienneteAnnees} an(s)</c:when>
                                            <c:otherwise><span class="empty-value">Non renseigné</span></c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="section">
                            <h3 class="section-title">Rémunération</h3>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">Salaire employé</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty employe.salaire}">${employe.salaire} Ar</c:when>
                                            <c:otherwise><span class="empty-value">Non renseigné</span></c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <c:if test="${not empty employe.salaireBase}">
                                    <div class="info-item">
                                        <span class="info-label">Salaire base contrat</span>
                                        <span class="info-value">${employe.salaireBase} Ar</span>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <div class="section">
                            <h3 class="section-title">Statut</h3>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">Statut actuel</span>
                                    <span class="info-value">
                                        <span class="badge ${employe.statut == 'actif' ? 'badge-success' : 'badge-danger'}">
                                            ${employe.statut}
                                        </span>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Onglet Contact -->
                    <div id="contact" class="tab-content">
                        <div class="section">
                            <h3 class="section-title">Coordonnées</h3>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">Téléphone</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty employe.telephone}">
                                                ${employe.telephone}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="empty-value">Non renseigné</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Email</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty employe.mail}">${employe.mail}</c:when>
                                            <c:otherwise><span class="empty-value">Non renseigné</span></c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Adresse</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty employe.adresse}">${employe.adresse}</c:when>
                                            <c:otherwise><span class="empty-value">Non renseigné</span></c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="section">
                            <h3 class="section-title">Contact d'Urgence</h3>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">Nom</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty employe.contactUrgenceNom}">
                                                ${employe.contactUrgenceNom}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="empty-value">Non renseigné</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Téléphone</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty employe.contactUrgenceTelephone}">
                                                ${employe.contactUrgenceTelephone}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="empty-value">Non renseigné</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="section">
                            <h3 class="section-title">Informations Administratives</h3>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">Numéro sécurité sociale</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty employe.numeroSecuriteSociale}">
                                                ${employe.numeroSecuriteSociale}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="empty-value">Non renseigné</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Onglet Contrat -->
                    <div id="contrat" class="tab-content">
                        <c:choose>
                            <c:when test="${not empty employe.typeContrat}">
                                <div class="section">
                                    <h3 class="section-title">Contrat Actuel</h3>
                                    <div class="info-grid">
                                        <div class="info-item">
                                            <span class="info-label">Type de contrat</span>
                                            <span class="info-value">
                                                <span class="badge 
                                                    <c:choose>
                                                        <c:when test="${employe.typeContrat == 'CDI'}">badge-success</c:when>
                                                        <c:when test="${employe.typeContrat == 'CDD'}">badge-warning</c:when>
                                                        <c:otherwise>badge-info</c:otherwise>
                                                    </c:choose>">
                                                    ${employe.typeContrat}
                                                </span>
                                            </span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">Date de début</span>
                                            <span class="info-value">${employe.dateDebut}</span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">Date de fin</span>
                                            <span class="info-value">
                                                <c:choose>
                                                    <c:when test="${not empty employe.dateFin}">
                                                        ${employe.dateFin}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="empty-value">Indéterminée</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">Classification</span>
                                            <span class="info-value">
                                                <c:choose>
                                                    <c:when test="${not empty employe.classification}">
                                                        ${employe.classification}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="empty-value">Non spécifiée</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">Salaire de base</span>
                                            <span class="info-value">${employe.salaireBase} Ar</span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">Période d'essai</span>
                                            <span class="info-value">
                                                <c:choose>
                                                    <c:when test="${employe.periodeEssaiJours > 0}">
                                                        ${employe.periodeEssaiJours} jours (jusqu'au ${employe.dateFinEssai})
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="empty-value">Aucune</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="section">
                                    <div style="text-align: center; padding: 3rem; color: var(--gray);">
                                        <i class="fas fa-file-contract" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.5;"></i>
                                        <h3>Aucun contrat actif</h3>
                                        <p>Cet employé n'a pas de contrat en cours.</p>
                                        <a href="${pageContext.request.contextPath}/rh/contrat/creer?id_employe=${employe.id}" 
                                           class="back-btn" style="margin-top: 1rem;">
                                            <i class="fas fa-plus"></i>
                                            Créer un contrat
                                        </a>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Gestion des onglets
        function openTab(tabName) {
            // Masquer tous les contenus d'onglets
            const tabContents = document.getElementsByClassName('tab-content');
            for (let i = 0; i < tabContents.length; i++) {
                tabContents[i].classList.remove('active');
            }

            // Désactiver tous les onglets
            const tabs = document.getElementsByClassName('tab');
            for (let i = 0; i < tabs.length; i++) {
                tabs[i].classList.remove('active');
            }

            // Activer l'onglet sélectionné
            document.getElementById(tabName).classList.add('active');
            event.currentTarget.classList.add('active');
        }
    </script>
</body>
</html>