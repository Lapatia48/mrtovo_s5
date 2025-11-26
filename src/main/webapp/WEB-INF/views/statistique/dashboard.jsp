<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Statistiques RH - BusinessSuite RH</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Segoe UI', sans-serif;
            line-height: 1.5;
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
            border-bottom: 1px solid var(--gray-light);
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

        /* KPI Cards */
        .kpi-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .kpi-card {
            background: var(--white);
            padding: 2rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            text-align: center;
            transition: var(--transition);
            border-left: 4px solid var(--accent);
        }

        .kpi-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(26, 54, 93, 0.15);
        }

        .kpi-icon {
            font-size: 2.5rem;
            color: var(--accent);
            margin-bottom: 1rem;
        }

        .kpi-title {
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--gray);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
        }

        .kpi-value {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--navy-blue);
            line-height: 1;
            margin-bottom: 0.5rem;
        }

        .kpi-subtitle {
            font-size: 0.875rem;
            color: var(--gray);
        }

        /* Charts Grid */
        .charts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .chart-card {
            background: var(--white);
            padding: 1.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .chart-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--navy-blue);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .chart-title i {
            color: var(--accent);
        }

        .chart-container {
            position: relative;
            height: 300px;
            width: 100%;
        }

        /* Tables Grid */
        .tables-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .table-card {
            background: var(--white);
            padding: 1.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .table-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--navy-blue);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .table-title i {
            color: var(--accent);
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.875rem;
        }

        .data-table th {
            background: var(--gray-lighter);
            color: var(--navy-blue);
            padding: 0.75rem;
            text-align: left;
            font-weight: 600;
            border-bottom: 1px solid var(--gray-light);
        }

        .data-table td {
            padding: 0.75rem;
            border-bottom: 1px solid var(--gray-light);
        }

        .data-table tbody tr:hover {
            background: var(--gray-lighter);
        }

        .text-end {
            text-align: right;
        }

        .text-muted {
            color: var(--gray);
        }

        /* Alert */
        .alert {
            padding: 1rem 1.5rem;
            border-radius: var(--border-radius);
            margin-bottom: 2rem;
            border: 1px solid transparent;
        }

        .alert-danger {
            background: rgba(220, 53, 69, 0.1);
            color: var(--danger);
            border-color: rgba(220, 53, 69, 0.2);
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
            .charts-grid {
                grid-template-columns: 1fr;
            }
            .tables-grid {
                grid-template-columns: 1fr;
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
            .kpi-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <!-- Sidebar Navigation -->
        <jsp:include page="sidebarRh.jsp" />

        <!-- Contenu Principal -->
        <main class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <div class="page-title">
                    <h2>Dashboard des Statistiques RH</h2>
                    <p>Vue d'ensemble des indicateurs clés des ressources humaines</p>
                </div>
            </div>

            <!-- Messages d'erreur/succès -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>
            
            <!-- KPI Principaux -->
            <div class="kpi-grid">
                <div class="kpi-card">
                    <div class="kpi-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="kpi-title">Effectif Total</div>
                    <div class="kpi-value">${effectifTotal}</div>
                    <div class="kpi-subtitle">Employés actifs</div>
                </div>
                
                <div class="kpi-card">
                    <div class="kpi-icon">
                        <i class="fas fa-calendar-alt"></i>
                    </div>
                    <div class="kpi-title">Ancienneté Moyenne</div>
                    <div class="kpi-value">${ancienneteMoyenne}</div>
                    <div class="kpi-subtitle">Années d'ancienneté</div>
                </div>
                
                <div class="kpi-card">
                    <div class="kpi-icon">
                        <i class="fas fa-building"></i>
                    </div>
                    <div class="kpi-title">Départements</div>
                    <div class="kpi-value">${effectifDepartement.size()}</div>
                    <div class="kpi-subtitle">Départements actifs</div>
                </div>
                
                <div class="kpi-card">
                    <div class="kpi-icon">
                        <i class="fas fa-file-contract"></i>
                    </div>
                    <div class="kpi-title">Types de Contrat</div>
                    <div class="kpi-value">${effectifContrat.size()}</div>
                    <div class="kpi-subtitle">Contrats différents</div>
                </div>
            </div>

            <!-- Graphiques -->
            <div class="charts-grid">
                <!-- Effectif par Département -->
                <div class="chart-card">
                    <div class="chart-header">
                        <div class="chart-title">
                            <i class="fas fa-building"></i>
                            Effectif par Département
                        </div>
                    </div>
                    <div class="chart-container">
                        <canvas id="departementChart"></canvas>
                    </div>
                </div>
                
                <!-- Répartition par Âge -->
                <div class="chart-card">
                    <div class="chart-header">
                        <div class="chart-title">
                            <i class="fas fa-chart-pie"></i>
                            Répartition par Tranche d'Âge
                        </div>
                    </div>
                    <div class="chart-container">
                        <canvas id="ageChart"></canvas>
                    </div>
                </div>

                <!-- Types de Contrat -->
                <div class="chart-card">
                    <div class="chart-header">
                        <div class="chart-title">
                            <i class="fas fa-file-contract"></i>
                            Types de Contrat
                        </div>
                    </div>
                    <div class="chart-container">
                        <canvas id="contratChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Tableaux détaillés -->
            <div class="tables-grid">
                <!-- Départements -->
                <div class="table-card">
                    <div class="table-header">
                        <div class="table-title">
                            <i class="fas fa-building"></i>
                            Effectif par Département
                        </div>
                    </div>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Département</th>
                                <th class="text-end">Effectif</th>
                                <th class="text-end">Pourcentage</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dept" items="${effectifDepartement}">
                                <tr>
                                    <td>${dept.key}</td>
                                    <td class="text-end"><strong>${dept.value}</strong></td>
                                    <td class="text-end text-muted">
                                        <c:set var="pourcentage" value="${(dept.value / effectifTotal) * 100}"/>
                                        ${String.format('%.1f', pourcentage)}%
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Tranches d'âge -->
                <div class="table-card">
                    <div class="table-header">
                        <div class="table-title">
                            <i class="fas fa-user-clock"></i>
                            Répartition par Tranche d'Âge
                        </div>
                    </div>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Tranche d'âge</th>
                                <th class="text-end">Effectif</th>
                                <th class="text-end">Pourcentage</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="totalAge" value="0"/>
                            <c:forEach var="age" items="${effectifAge}">
                                <c:set var="totalAge" value="${totalAge + age.value}"/>
                            </c:forEach>
                            <c:forEach var="age" items="${effectifAge}">
                                <tr>
                                    <td>${age.key}</td>
                                    <td class="text-end"><strong>${age.value}</strong></td>
                                    <td class="text-end text-muted">
                                        <c:set var="pourcentage" value="${(age.value / totalAge) * 100}"/>
                                        ${String.format('%.1f', pourcentage)}%
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Types de contrat -->
                <div class="table-card">
                    <div class="table-header">
                        <div class="table-title">
                            <i class="fas fa-file-signature"></i>
                            Types de Contrat
                        </div>
                    </div>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Type de contrat</th>
                                <th class="text-end">Effectif</th>
                                <th class="text-end">Pourcentage</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="totalContrat" value="0"/>
                            <c:forEach var="contrat" items="${effectifContrat}">
                                <c:set var="totalContrat" value="${totalContrat + contrat.value}"/>
                            </c:forEach>
                            <c:forEach var="contrat" items="${effectifContrat}">
                                <tr>
                                    <td>${contrat.key}</td>
                                    <td class="text-end"><strong>${contrat.value}</strong></td>
                                    <td class="text-end text-muted">
                                        <c:set var="pourcentage" value="${(contrat.value / totalContrat) * 100}"/>
                                        ${String.format('%.1f', pourcentage)}%
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Couleurs pour les graphiques
        const colors = {
            blue: ['#4e73df', '#36b9cc', '#1cc88a', '#f6c23e', '#e74a3b', '#858796'],
            pastel: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40']
        };

        // Graphique Départements
        const deptCtx = document.getElementById('departementChart').getContext('2d');
        const deptLabels = [<c:forEach var="dept" items="${effectifDepartement}">'${dept.key}',</c:forEach>];
        const deptData = [<c:forEach var="dept" items="${effectifDepartement}">${dept.value},</c:forEach>];
        
        new Chart(deptCtx, {
            type: 'bar',
            data: {
                labels: deptLabels,
                datasets: [{
                    label: 'Nombre d\'employés',
                    data: deptData,
                    backgroundColor: colors.blue,
                    borderColor: colors.blue.map(color => color.replace('0.8', '1')),
                    borderWidth: 1,
                    borderRadius: 5
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: true,
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                const value = context.raw;
                                const total = ${effectifTotal};
                                const percentage = ((value / total) * 100).toFixed(1);
                                return `${context.dataset.label}: ${value} (${percentage}%)`;
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Nombre d\'employés'
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'Départements'
                        }
                    }
                }
            }
        });

        // Graphique Âges
        const ageCtx = document.getElementById('ageChart').getContext('2d');
        const ageLabels = [<c:forEach var="age" items="${effectifAge}">'${age.key}',</c:forEach>];
        const ageData = [<c:forEach var="age" items="${effectifAge}">${age.value},</c:forEach>];
        
        new Chart(ageCtx, {
            type: 'pie',
            data: {
                labels: ageLabels,
                datasets: [{
                    data: ageData,
                    backgroundColor: colors.pastel,
                    borderWidth: 2,
                    borderColor: '#ffffff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'right',
                        labels: {
                            padding: 15,
                            usePointStyle: true
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                const label = context.label;
                                const value = context.raw;
                                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                const percentage = ((value / total) * 100).toFixed(1);
                                return `${label}: ${value} employés (${percentage}%)`;
                            }
                        }
                    }
                }
            }
        });

        // Graphique Contrats
        const contratCtx = document.getElementById('contratChart').getContext('2d');
        const contratLabels = [<c:forEach var="contrat" items="${effectifContrat}">'${contrat.key}',</c:forEach>];
        const contratData = [<c:forEach var="contrat" items="${effectifContrat}">${contrat.value},</c:forEach>];
        
        new Chart(contratCtx, {
            type: 'doughnut',
            data: {
                labels: contratLabels,
                datasets: [{
                    data: contratData,
                    backgroundColor: colors.blue,
                    borderWidth: 2,
                    borderColor: '#ffffff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'right',
                        labels: {
                            padding: 15,
                            usePointStyle: true
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                const label = context.label;
                                const value = context.raw;
                                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                const percentage = ((value / total) * 100).toFixed(1);
                                return `${label}: ${value} employés (${percentage}%)`;
                            }
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>