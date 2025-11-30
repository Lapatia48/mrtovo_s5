<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Évaluation Employé - BusinessSuite RH</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
            --warning: #FFC107;
            --danger: #DC3545;
            --info: #0DCAF0;
            --border-radius: 12px;
            --box-shadow: 0 8px 30px rgba(26, 54, 93, 0.12);
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
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
            background: var(--cream);
            min-height: 100vh;
        }

        /* Layout Principal */
        .admin-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Navigation */
        .sidebar {
            width: 280px;
            background: var(--navy-blue);
            color: var(--white);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            transition: var(--transition);
            z-index: 1000;
        }

        .sidebar-header {
            padding: 2rem 1.5rem;
            border-bottom: 1px solid var(--navy-light);
        }

        .sidebar-header h1 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .sidebar-header p {
            font-size: 0.875rem;
            color: var(--gray-light);
            opacity: 0.8;
        }

        .nav-menu {
            padding: 1.5rem 0;
        }

        .nav-item {
            margin-bottom: 0.5rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 0.875rem 1.5rem;
            color: var(--white);
            text-decoration: none;
            transition: var(--transition);
            border-left: 3px solid transparent;
        }

        .nav-link:hover, .nav-link.active {
            background: var(--navy-light);
            border-left-color: var(--accent);
        }

        .nav-link i {
            margin-right: 0.75rem;
            width: 20px;
            text-align: center;
        }

        /* Contenu Principal */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
        }

        /* Top Bar */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--gray-light);
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

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--border-radius);
            font-weight: 500;
            font-size: 0.875rem;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: var(--navy-blue);
            color: var(--white);
        }

        .btn-primary:hover {
            background: var(--navy-light);
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: var(--gray-light);
            color: var(--navy-blue);
        }

        .btn-secondary:hover {
            background: var(--gray);
            color: var(--white);
        }

        /* Carte d'évaluation */
        .evaluation-card {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            overflow: hidden;
            max-width: 600px;
            margin: 0 auto;
        }

        .card-header {
            background: linear-gradient(135deg, var(--navy-blue), var(--navy-light));
            color: var(--white);
            padding: 2rem;
            text-align: center;
            position: relative;
        }

        .card-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" opacity="0.1"><circle cx="50" cy="50" r="2" fill="white"/></svg>') repeat;
        }

        .employee-name {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .employee-info {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .card-body {
            padding: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--navy-blue);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-label i {
            color: var(--accent);
            width: 16px;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid var(--gray-light);
            border-radius: var(--border-radius);
            font-size: 0.875rem;
            font-family: 'Inter', sans-serif;
            transition: var(--transition);
            background: var(--white);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 100px;
        }

        /* Système d'étoiles */
        .rating-section {
            text-align: center;
            padding: 1rem 0;
        }

        .rating-label {
            font-size: 1rem;
            font-weight: 600;
            color: var(--navy-blue);
            margin-bottom: 1rem;
        }

        .etoiles {
            display: inline-flex;
            gap: 0.5rem;
            background: var(--gray-lighter);
            padding: 1rem 2rem;
            border-radius: var(--border-radius);
        }

        .etoiles i {
            font-size: 2rem;
            color: var(--gray-light);
            cursor: pointer;
            transition: var(--transition);
        }

        .etoiles i:hover {
            transform: scale(1.2);
        }

        .etoiles i.active {
            color: #FFD700;
            text-shadow: 0 2px 8px rgba(255, 215, 0, 0.4);
        }

        .etoiles i.active ~ i {
            color: var(--gray-light);
        }

        .rating-value {
            margin-top: 1rem;
            font-size: 0.875rem;
            color: var(--gray);
            font-weight: 500;
        }

        /* Actions du formulaire */
        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 2px solid var(--gray-light);
        }

        /* Message d'erreur */
        .alert {
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1.5rem;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .alert-error {
            background: rgba(220, 53, 69, 0.1);
            color: var(--danger);
            border: 1px solid rgba(220, 53, 69, 0.2);
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .sidebar {
                width: 250px;
            }
            .main-content {
                margin-left: 250px;
            }
        }

        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }
            .sidebar.active {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }
            .top-bar {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
            .evaluation-card {
                margin: 0;
            }
            .card-body {
                padding: 1.5rem;
            }
            .form-actions {
                flex-direction: column;
            }
            .etoiles {
                padding: 0.75rem 1rem;
            }
            .etoiles i {
                font-size: 1.75rem;
            }
        }

        @media (max-width: 576px) {
            .card-header {
                padding: 1.5rem;
            }
            .employee-name {
                font-size: 1.25rem;
            }
        }

        /* Animation pour les étoiles */
        @keyframes starPop {
            0% { transform: scale(1); }
            50% { transform: scale(1.3); }
            100% { transform: scale(1); }
        }

        .etoiles i.active {
            animation: starPop 0.3s ease;
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <!-- Sidebar Navigation -->
        <jsp:include page="../sidebar/sidebarRh.jsp" />

        <!-- Contenu Principal -->
        <main class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <div class="page-title">
                    <h2>Évaluation des Performances</h2>
                    <p>Évaluation mensuelle des collaborateurs</p>
                </div>
                <div class="user-menu">
                    <a href="${pageContext.request.contextPath}/rh/employe" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Retour à la liste
                    </a>
                </div>
            </div>

            <!-- Messages d'erreur -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <!-- Carte d'évaluation -->
            <div class="evaluation-card">
                <div class="card-header">
                    <div class="employee-name">${employe.nom}</div>
                    <div class="employee-info">
                        ${employe.poste} • ${employe.departement}
                    </div>
                </div>

                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/rh/employe/evaluation/soumettre" method="post">
                        <input type="hidden" name="id_employe" value="${employe.id}" />

                        <div class="form-group">
                            <label class="form-label" for="mois">
                                <i class="fas fa-calendar-alt"></i>
                                Mois d'évaluation
                            </label>
                            <select class="form-control" id="mois" name="mois" required>
                                <c:forEach var="m" items="${['Janvier','Février','Mars','Avril','Mai','Juin','Juillet','Août','Septembre','Octobre','Novembre','Décembre']}">
                                    <option value="${m}">${m}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="annee">
                                <i class="fas fa-calendar"></i>
                                Année d'évaluation
                            </label>
                            <select class="form-control" id="annee" name="annee" required>
                                <c:forEach var="a" begin="2025" end="2035">
                                    <option value="${a}">${a}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Système de notation par étoiles -->
                        <div class="rating-section">
                            <div class="rating-label">Note de performance</div>
                            <div class="etoiles">
                                <input type="hidden" name="note" id="note" value="0"/>
                                <i class="fas fa-star" data-value="1"></i>
                                <i class="fas fa-star" data-value="2"></i>
                                <i class="fas fa-star" data-value="3"></i>
                                <i class="fas fa-star" data-value="4"></i>
                                <i class="fas fa-star" data-value="5"></i>
                            </div>
                            <div class="rating-value" id="rating-text">Sélectionnez une note</div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="commentaires">
                                <i class="fas fa-comment"></i>
                                Commentaires et observations
                            </label>
                            <textarea class="form-control" id="commentaires" name="commentaires" 
                                      placeholder="Décrivez les performances, points forts et axes d'amélioration..."></textarea>
                        </div>

                        <div class="form-actions">
                            <button type="reset" class="btn btn-secondary">
                                <i class="fas fa-redo"></i>
                                Réinitialiser
                            </button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-paper-plane"></i>
                                Soumettre l'évaluation
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Système de notation par étoiles
        const stars = document.querySelectorAll('.etoiles i');
        const noteInput = document.getElementById('note');
        const ratingText = document.getElementById('rating-text');

        const ratingLabels = {
            0: "Sélectionnez une note",
            1: "Insuffisant - Amélioration nécessaire",
            2: "Moyen - Satisfait partiellement",
            3: "Bon - Atteint les objectifs",
            4: "Très bon - Dépasse les attentes",
            5: "Excellent - Performance exceptionnelle"
        };

        stars.forEach(star => {
            star.addEventListener('click', () => {
                const val = parseInt(star.getAttribute('data-value'));
                noteInput.value = val;
                
                // Mise à jour des étoiles
                stars.forEach(s => {
                    const starVal = parseInt(s.getAttribute('data-value'));
                    s.classList.toggle('active', starVal <= val);
                });
                
                // Mise à jour du texte
                ratingText.textContent = ratingLabels[val];
                ratingText.style.color = val >= 4 ? '#198754' : val >= 3 ? '#FFC107' : '#DC3545';
            });

            // Effet hover
            star.addEventListener('mouseenter', () => {
                const hoverVal = parseInt(star.getAttribute('data-value'));
                stars.forEach(s => {
                    const starVal = parseInt(s.getAttribute('data-value'));
                    s.style.color = starVal <= hoverVal ? '#FFD700' : '#DEE2E6';
                });
            });

            star.addEventListener('mouseleave', () => {
                const currentVal = parseInt(noteInput.value);
                stars.forEach(s => {
                    const starVal = parseInt(s.getAttribute('data-value'));
                    s.style.color = starVal <= currentVal ? '#FFD700' : '#DEE2E6';
                });
            });
        });

        // Menu responsive
        document.addEventListener('DOMContentLoaded', function() {
            const menuToggle = document.createElement('button');
            menuToggle.innerHTML = '<i class="fas fa-bars"></i>';
            menuToggle.style.cssText = `
                position: fixed;
                top: 1rem;
                left: 1rem;
                background: var(--navy-blue);
                color: white;
                border: none;
                padding: 0.75rem;
                border-radius: var(--border-radius);
                cursor: pointer;
                z-index: 1001;
                display: none;
            `;
            
            document.body.appendChild(menuToggle);
            
            menuToggle.addEventListener('click', function() {
                document.querySelector('.sidebar').classList.toggle('active');
            });

            function handleResize() {
                if (window.innerWidth <= 992) {
                    menuToggle.style.display = 'block';
                } else {
                    menuToggle.style.display = 'none';
                    document.querySelector('.sidebar').classList.remove('active');
                }
            }

            window.addEventListener('resize', handleResize);
            handleResize();
        });
    </script>
</body>
</html>