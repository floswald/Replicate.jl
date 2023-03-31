using PkgTemplates


function make_template(gh_user::String,loc::String = "~/")
    Template(; 
        user=gh_user,
        dir=loc,
        julia=v"1.8",
        plugins=[
            License(; name="MIT"),
            Git(; manifest=false, ssh=true),
            GitHubActions(; x86=true, extra_versions = [PkgTemplates.default_version(),"1.8"]),
            Documenter{GitHubActions}(),
            Readme(file = joinpath(@__DIR__,"readme-template.md"))
        ],
    )
end