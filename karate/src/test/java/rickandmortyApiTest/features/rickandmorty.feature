@RickandMorty
Feature: Testando API Rick and Morty

Background: Executa antes de cada teste
    * url 'https://rickandmortyapi.com/api'

Scenario: Testando busca a episodio que nao existe
    Given path '/character/3000'
    When method get
    Then status 404
    And match response.error == "Character not found"

Scenario: Testando se tem a quantia certa de personagens
    Given path '/character'
    When method get
    Then match $.info.count == 826

Scenario: Testando a busca de mais de um personagem
    Given path '/character/13,22,35,47'
    When method get
    Then match $ ==  '#[4]'

Scenario Outline: Testando dados de alguns personagens
    Given path '/character/' + <id>
    When method get
    Then match $.name == <name>
    And match $.status == <status>
    And match $.species == <especie>
    # vai dar erro pois o Armagheadon é Alien e nao Humanoid
    Examples: Examplos
    |id         |name           |status         |especie        |
    |11         |"Albert Einstein"|"Dead"       |"Human"        |
    |24         |"Armagheadon"  |"Alive"        |"Humanoid"     |
    |221        |"Melissa"      |"Alive"        |"Mythological Creature"|
    |234        |"Morty Smith"  |"Dead"         |"Human"        |
    |666        |"Squeeb"       |"Alive"        |"Humanoid"     |

Scenario: Testando dados de uma localização
    Given path '/location/1'
    When method get
    Then match $ contains {id: '#number',  name: '#string', type: '#string', dimension: '#string',residents: '#array', url: '#string', created: '#string'}
    And match $.name == "Earth (C-137)"
    And match $.type == "Planet"
    # vai dar erro pois era esperado Dimension C-137
    And match $.dimension == "Dimension C-131"
    
Scenario Outline: Testando a busca de multiplos persogens com filtros
    Given path '/character/?name=' + <nome> + '&status=' + <status>
    When method get
    Then status 200
    And print response
    Examples: exemplos
    |nome        |status        |
    |"Rick"      |"Alive"       |
    |"Morty"     |"Alive"       |
    |"Summer"    |"Alive"       |
