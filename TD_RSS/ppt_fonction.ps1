function Add-pptObject {
    

    process {
        $objPPT = New-Object -ComObject PowerPoint.Application
        $objPPT.Visible = -1  # Make PowerPoint visible
        return $objPPT.Presentations.Add()
    }

    
}

function Add-Slide{
    param (
        [Parameter(Mandatory=$true)]
        $presentation,
        [Parameter(Mandatory=$true)]
        [int]$slideIndex,
        [Parameter(Mandatory=$true)]
        [int]$layoutType
    )

    process {
        $slide = $presentation.Slides.Add($slideIndex, $layoutType)
        return $slide
    }
}

function Add-SlideItemText{
    param (
        [Parameter(Mandatory=$true)]
        $slide,
        [Parameter(Mandatory=$true)]
        [int]$itemIndex,
        [Parameter(Mandatory=$true)]
        [string]$text
    )

    process {
        $slide.Shapes.Item($itemIndex).TextFrame.TextRange.Text = $text
    }
}

function Save-Ppt{
    param (
        [Parameter(Mandatory=$true)]
        $presentation,
        [Parameter(Mandatory=$true)]
        [string]$path
    )

    process {
        # 32 corresponds to the standard .pptx format
        $presentation.SaveAs($path, 32)
    }
}