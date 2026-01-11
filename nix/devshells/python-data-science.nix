{ pkgs }:

let
  pkgsWithConfig = import pkgs.path {
    config = {
      allowUnfree = true;
    };
    inherit (pkgs) system;
  };
in
pkgsWithConfig.mkShell {
  name = "python-data-science";
  packages = with pkgsWithConfig; [
    # Core Python and Jupyter
    python3
    jupyter

    # Data Science Libraries
    python3Packages.numpy
    python3Packages.pandas
    python3Packages.matplotlib
    python3Packages.scipy
    python3Packages.scikit-learn
    python3Packages.statsmodels

    # Data Visualization
    python3Packages.seaborn
    python3Packages.plotly
    python3Packages.altair

    # Web Scraping
    python3Packages.beautifulsoup4
    python3Packages.lxml
    python3Packages.selenium
    python3Packages.requests
    python3Packages.playwright

    # Database Interaction
    python3Packages.sqlalchemy
    python3Packages.pymongo
    python3Packages.psycopg2

    # Additional utilities
    python3Packages.ipython
    python3Packages.notebook
    python3Packages.nbconvert
  ];

  shellHook = ''
    echo "Entering Python Data Science and Web Scraping Environment"
    playwright install
  '';
}
